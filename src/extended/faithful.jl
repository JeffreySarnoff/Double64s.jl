#=
    reference

    [LangRump2020]
    Faithfully Rounded Floating-point Computations
    by M. Lange, S.M. Rump
    ACM Transactions on Mathematical Software, Vol. 46, No. 3, 
    Article 21. Publication date: July 2020.
    https://doi.org/10.1145/3290955
=#
#=

[LangRump2020 p5] (linespacing added)

Our basic pair operations to be analyzed are
CPairSum, CPairProd, CPairDiv, and CPairSqrt.

As an implementation of a pair arithmetic,
these functions have similarities with the
respective doubledouble operations.

To be more specific, CPairSum is very similar
to Dekker’s add2 but without the final
Fast2Sum call for normalization as well as
a different evaluation order, and CPairProd
is essentially the algorithm mul2 in Dekker’s
paper again without the final Fast2Sum.

=#

struct CPair{T}
    hi::T
    lo::T
end

hi(x::CPair) = x.hi
lo(x::CPair) = x.lo
hilo(x::CPair) = (x.hi, x.lo)
function CPairSum(ahi::T, alo::T, bhi::T, blo::T) where {T}
    c = ahi + bhi
    t = ahi + bhi - c
    s = alo + blo
    g = t + s
    (c, g)
end

function CPairSum(a::CPair{T}, b::CPair{T}) where {T}
    ahi, alo = hilo(ae)
    bhi, blo = hilo(bf)
    CPairSum(ahi, alo, bhi, blo)
end

function CPairSum(a::CPair{T}, b::CPair{T}) where {T}
    ahi, alo = hilo(ae)
    bhi, blo = hilo(bf)
    c = ahi + bhi
    t = ahi + bhi - c
    s = alo + blo
    g = t + s
    CPair(c, g)
end

function CPairDiff(a::CPair{T}, b::CPair{T}) where {T}
    ahi, alo = hilo(ae)
    bhi, blo = hilo(bf)
    c = ahi - bhi
    t = ahi - bhi - c
    s = alo - blo
    g = t + s
    CPair(c, g)
end

function CPairProd(a::CPair{T}, b::CPair{T}) where {T}
    ahi, alo = hilo(ae)
    bhi, blo = hilo(bf)
    c = ahi * bhi
    t = fma(a, b, -c)
    q = ahi * blo
    r = bhi * alo
    s = q + r
    g = t + s
    CPair(c, g)
end

function CPairDiv(a::CPair{T}, b::CPair{T}) where {T}
    ahi, alo = hilo(ae)
    bhi, blo = hilo(bf)
    c = ahi / bhi
    t = fma(-bhi, c, ahi)
    p = t + alo
    q = c * blo
    r = p - q
    s = bhi + blo
    g = r / s
    CPair(c, g)
end

function CPairInv(b::CPair{T}) where {T}
    bhi, blo = hilo(bf)
    c = one(T) / bhi
    t = fma(-bhi, c, one(T))
    q = c * blo
    r = t - q
    s = bhi + blo
    g = r / s
    CPair(c, g)
end

function CPairSqrt(a::CPair{T}) where {T}
    ahi, alo = hilo(ae)
    c = sqrt(ahi)
    t = fma(-c, c, ahi)
    r = t + alo
    s = c + c
    g = r / s
    CPair(c, g)
end

