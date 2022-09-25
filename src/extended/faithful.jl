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

function CPairSum(ae::CPair{T}, bf::CPair{T}) with {T}
    a, e = hilo(ae)
    b, f = hilo(bf)
    c = a + b
    t = a + b - c
    s = e + f
    g = t + s
    CPair(c, g)
end

function CPairDiff(ae::CPair{T}, bf::CPair{T}) with {T}
    a, e = hilo(ae)
    b, f = hilo(bf)
    c = a - b
    t = a - b - c
    s = e - f
    g = t + s
    CPair(c, g)
end

function CPairProd(ae::CPair{T}, bf::CPair{T}) with {T}
    a, e = hilo(ae)
    b, f = hilo(bf)
    c = a * b
    t = fma(a, b, -c)
    q = a * f
    r = b * e
    s = q + r
    g = t + s
    CPair(c, g)
end

function CPairDiv(ae::CPair{T}, bf::CPair{T}) with {T}
    a, e = hilo(ae)
    b, f = hilo(bf)
    c = a / b
    t = fma(-b, c, a)
    p = t + e
    q = c * f
    r = p - q
    s = b + f
    g = r / s
    CPair(c, g)
end

function CPairInv(bf::CPair{T}) with {T}
    b, f = hilo(bf)
    c = one(T) / b
    t = fma(-b, c, one(T))
    q = c * f
    r = t - q
    s = b + f
    g = r / s
    CPair(c, g)
end

function CPairSqrt(ae::CPair{T}) with {T}
    a, e = hilo(ae)
    c = sqrt(a)
    t = fma(-c, c, a)
    r = t + e
    s = c + c
    g = r / s
    CPair(c, g)
end















