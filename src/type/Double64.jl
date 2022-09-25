struct Double64 <: AbstractFloat
    hi::Float64
    lo::Float64
  
    function Double64(hilo::Tuple{Float64, Float64})
        new(hilo[1], hilo[2])
    end
end

function Double64(a::Float64, b::Float64)
    Double64(two_sum(a, b))
end
    
hi(x::Double64) = x.hi
lo(x::Double64) = x.lo

hilo(x::Double64) = (x.hi, x.lo)
lohi(x::Double64) = (x.lo, x.hi)

function Base.show(io::IO, ::MIME"text/plain", x::Double64)
      print(io, hi(x))
end

