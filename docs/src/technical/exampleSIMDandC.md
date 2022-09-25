#=

from https://discourse.julialang.org/t/c-routine-uses-avx-intrinsics/87777/3

Part I: Creating Julia Focused Facilites through shared C functions 
        ** The Example from Julia's Docs **

(1) Compile your code:

     gcc -mavx -fPIC -shared -o libdist.so avx.c

(2) open julia in the same dir:

    julia> pwd()
           "/mnt/d/proj/Julia/JuliaEn/87777-ccall"

    shell> ls
    avx.c  libdist.so

(3) use the library

julia> pwd()
"/mnt/d/proj/Julia/JuliaEn/87777-ccall"

shell> ls
avx.c  libdist.so

julia> const m256 = NTuple{8, VecElement{Float32}}
NTuple{8, VecElement{Float32}}

julia> a = m256(ntuple(i -> VecElement(sin(Float32(i))), 8))
(VecElement{Float32}(0.84147096f0), VecElement{Float32}(0.9092974f0), VecElement{Float32}(0.14112f0), VecElement{Float32}(-0.7568025f0), VecElement{Float32}(-0.9589243f0), VecElement{Float32}(-0.2794155f0), VecElement{Float32}(0.6569866f0), VecElement{Float32}(0.98935825f0))

julia> b = m256(ntuple(i -> VecElement(cos(Float32(i))), 8))
(VecElement{Float32}(0.5403023f0), VecElement{Float32}(-0.41614684f0), VecElement{Float32}(-0.9899925f0), VecElement{Float32}(-0.6536436f0), VecElement{Float32}(0.2836622f0), VecElement{Float32}(0.96017027f0), VecElement{Float32}(0.75390226f0), VecElement{Float32}(-0.14550003f0))

julia> function call_dist(a::m256, b::m256)
           @ccall "./libdist".dist(a::m256, b::m256)::m256
       end
call_dist (generic function with 1 method)

julia> println(call_dist(a,b))
(VecElement{Float32}(0.99999994f0), VecElement{Float32}(0.99999994f0), VecElement{Float32}(1.0f0), VecElement{Float32}(1.0f0), VecElement{Float32}(1.0f0), VecElement{Float32}(1.0f0), VecElement{Float32}(1.0f0), VecElement{Float32}(1.0f0))

-------------------------- \/ 

Note: I’m using "./libdist" to call the lib.
Calling the library directly using the name will give an error: “ERROR: could not load library “libdist””.
Maybe I need to set some environment variables.

To load the shared libraries under the current path, you need to modify DL_LOAD_PATH: push!(DL_LOAD_PATH, ".")

julia> ccall((:dist, "libdist"), (m256), (m256,m256), a,b)
ERROR: could not load library "libdist"
libdist.so: cannot open shared object file: No such file or directory
Stacktrace:
 [1] top-level scope
   @ ./REPL[36]:1

julia> push!(DL_LOAD_PATH, ".")
1-element Vector{String}:
 "."

julia> ccall((:dist, "libdist"), (m256), (m256,m256), a,b)
(VecElement{Float32}(0.99999994f0), VecElement{Float32}(0.99999994f0), VecElement{Float32}(1.0f0), VecElement{Float32}(1.0f0), VecElement{Float32}(1.0f0), VecElement{Float32}(1.0f0), VecElement{Float32}(1.0f0), VecElement{Float32}(1.0f0))

------------------------- \/ 

Next, you may want to use GitHub - JuliaPackaging/BinaryBuilder.jl: Binary Dependency Builder for Julia 2 to automatically compile the C libraries for each platform and package them as jll package.

Then you can simply using LibDist_jll.jl in julia.


------------------------- \ / ----------------------------
                        -  *  -
------------------------- / \ ----------------------------

from Chris Elrod

The ccall will not be inlined, so do not use it (non-performant)

Use llvmcall if you want performance.
You have access to everything intrinsic Clang is capable of that way.

LLVM does a great job.  Julia thankfully exposes that to users. 
If you want portability, don’t call generic llvm Vec for instructions. 
(Clang unfortunately does not.)

Here is an example of calling an instruction 
from a particular instruction set: 

   VectorizationBase.jl/conflict.jl 
   at master · JuliaSIMD/VectorizationBase.jl


function conflictquote(W::Int=16, bits::Int = 32)
  @assert bits == 32 || bits == 64
  s = bits == 32 ? 'd' : 'q'
  typ = "i$(bits)"
  vtyp = "<$W x $(typ)>";
  op = "@llvm.x86.avx512.conflict.$s.$(bits*W)"
  decl = "declare <$W x $(typ)> $op(<$W x $(typ)>)"
  instrs = "%res = call <$W x $(typ)> $op(<$W x $(typ)> %0)\n ret <$W x $(typ)> %res"
  T = Symbol(:UInt, bits)
  llvmcall_expr(
    decl,
    instrs,
    :(_Vec{$W,$T}),
    :(Tuple{_Vec{$W,$T}}),
    vtyp,
    [vtyp],
    [:(data(v))],
  )
end

@generated function vpconflict(v::Vec{W,T}) where {W,T}
  conflictquote(W, 8sizeof(T))
end


------------------------- \ / ----------------------------
                        -  *  -
------------------------- / \ ----------------------------



