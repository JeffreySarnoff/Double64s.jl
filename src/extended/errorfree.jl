#=

`hi` is the most significant portion of a result
`lo` is of magnitude < ulp(hi) `hi == hi + lo`.

The number that begins a function name always matches
the number of values returned. These three `two_sum`
methods, in the order given, take 2, 3, 4 arguments.
`two_sum(a, b), two_sum(a, b, c), two_sum(a, b, c, d)`
All return *two* values `(hi, lo)`. 

`two_inv(x)` and `two_sqrt(x)` are single argument functions,
each returns two values `(hi, lo)`.

The values returned are given in descending magnitude
and are successively separated so the greater magnitude
is unchanged when the lesser magnitude is added to it
(they are additively non-overlapping).

`two_<op>(a, ...)` ⤇ (hi, lo)
`three_<op>(a, ...)` ⤇ (hi, mid, lo)

=#


# with arguments sorted by magnitude

"""
    two_hilo_sum(a, b)

*unchecked* requirement `|a| ≥ |b|`

Computes `hi = fl(a+b)` and `lo = err(a+b)`.
"""
@inline function two_hilo_sum(a::T, b::T) where {T}
    hi = a + b
    lo = b - (hi - a)
    return hi, lo
end

two_hilo_sum(x::Tuple{T,T}) where {T} = two_hilo_sum(x[1], x[2])

"""
    two_hilo_sum(a, b, c)
    
*unchecked* requirement `|a| ≥ |b| ≥ |c|`

Computes `hi = fl(a+b+c)` and `lo = err(a+b+c)`.
"""
function two_hilo_sum(a::T, b::T, c::T) where {T}
    lo, t = two_hilo_sum(b, c)
    hi, lo = two_hilo_sum(hilo_bymag(a, lo))
    lo += t
    hi, lo = two_hilo_sum(hi, lo)
    return hi, lo
end

two_hilo_sum(x::Tuple{T,T,T}) where {T} = two_hilo_sum(x[1], x[2], x[3])


"""
    two_hilo_diff(a, b)
    
*unchecked* requirement `|a| ≥ |b|`

Computes `hi = fl(a-b)` and `lo = err(a-b)`.
"""
@inline function two_hilo_diff(a::T, b::T) where {T}
    hi = a - b
    lo = (a - hi) - b
    hi, lo
end

two_hilo_diff(x::Tuple{T,T}) where {T} = two_hilo_diff(x[1], x[2])

"""
    two_hilo_diff(a, b, c)

*unchecked* requirement `|a| ≥ |b| ≥ |c|`

Computes `hi = fl(a-b-c)` and `lo = err(a-b-c)`.
"""
function two_hilo_diff(a::T, b::T, c::T) where {T}
    lo, t = two_hilo_diff(-b, c)
    hi, lo = two_hilo_sum(hilo_bymag(a, lo))
    lo += t
    hi, lo = two_hilo_sum(hi, lo)
    return hi, lo
end

two_hilo_diff(x::Tuple{T,T,T}) where {T} = two_hilo_diff(x[1], x[2], x[3])


"""
    two_square(a)

Computes `hi = fl(a*a)` and `lo = fl(err(a*a))`.
"""
@inline function two_square(a::T) where {T}
    hi = a * a
    lo = fma(a, a, -hi)
    hi, lo
end

"""
    two_prod(a, b)

Computes `hi = fl(a*b)` and `lo = fl(err(a*b))`.
"""
@inline function two_prod(a::T, b::T) where {T}
    hi = a * b
    lo = fma(a, b, -hi)
    hi, lo
end

@inline max_min(a, b) = abs(a) < abs(b) ? (b, a) : (a, b)


"""
    hilo_bymag(a, b)

    orders `a, b` by decreasing magnitude
 
    calculates (hi, lo) as below
    ```
    absa, absb = abs(a), abs(b)
    hi = absa >= absb ? a : b
    lo = absa >= absb ? b : a
    (hi, lo)
    ```
"""
hilo_bymag(a::T, b::T) where {T<:AbstractFloat} =
    abs(a) < abs(b) ? (b, a) : (a, b)

#=

hilo_bymag(a::T, b::T) where {T<:AbstractFloat} =
    signbit(flipsign(a - b, a)) ? (b, a) : (a, b)

=#
