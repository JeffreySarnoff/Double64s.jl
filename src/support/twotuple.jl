hi(a,b) = a
lo(a,b) = b

hi(ab::NTuple{2,T}) where {T} = ab[1]
lo(ab::NTuple{2,T}) where {T} = ab[2]

twotuple(a, b) = (a, b)
twotuple(ab::NTuple{2,T}) where {T} = ab

const HILO = NamedTuple{(:hi, :lo), Tuple{Float64, Float64})

hi(x::HILO) = x.hi
lo(x::HILO) = x.lo

hilo(a, b) = HILO((a, b))
hilo(ab::NTuple{2,Float64}) = HILO(ab)

hilotuple(a, b) = hilo(max_min_mag(a,b))
hilotuple(ab::NTuple{2,T}) where {T} = hilo(max_min_mag(ab[1], ab[2]))

min_max(a, b) = ifelse(a < b, (a, b), (b, a))
max_min(a, b) = ifelse(a < b, (b, a), (a, b))

min_max_mag(a, b) = ifelse(abs(a) < abs(b), (a, b), (b, a))
max_min_mag(a, b) = ifelse(abs(a) < abs(b), (b, a), (a, b))

