struct FloatD64 <: AbstractFloat
    hi::Float64
    lo::Float64
  
    FloatD64(hi::Float64, lo::Float64) =
        new(hi, lo)
end

function Double64(a::Float64, b::Float64)
    hi, lo = two_sum(a, b)
    FloatD64(hi, lo)
end
  
hi(x::FloatD64) = x.hi
lo(x::FloatD64) = x.lo

hilo(x::FloatD64) = (x.hi, x.lo)
lohi(x::FloatD64) = (x.lo, x.hi)

function Base.show(io::IO, ::MIME"text/plain", x::FloatD64)
      str = string("Double64(", x.hi, ", ", x.lo, ")")
      print(io, str)
end

