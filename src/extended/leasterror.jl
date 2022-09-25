#=
    The functions in this file cannot be fully error-free,
    the mathematics precludes that.  Nonetheless, they
    realize transformations that are nearly error-free.

    The inexactness is 
    More information is available at the end of this file,
    and through the links and references provided there.
=#


"""
    two_inv(a)

Computes `hi = fl(1/a)` and `lo = fl(~err(1/a))`.
"""
@inline function two_inv(b::T) where {T}
    hi = inv(b)
    lo = fma(-hi, b, one(T))
    lo /= b
    return hi, lo
end


"""
    two_div(a)

Computes `hi = fl(a/b)` and `lo = fl(~err(a/b))`.
"""
@inline function two_div(a::T, b::T) where {T}
    hi = a / b
    lo = fma(-hi, b, a)
    lo /= b
    return hi, lo
end


"""
    two_sqrt(a)

Computes `hi = fl(sqrt(a))` and `lo = fl(~err(sqrt(a)))`.
"""
@inline function two_sqrt(a::T) where {T}
    hi = sqrt(a)
    lo = fma(-hi, hi, a)
    lo /= 2
    lo /= hi
    return hi, lo
end


#=

"Concerning the division, the elementary rounding error
 is generally not a floating point number, so it cannot
 be computed exactly. Hence we cannot expect to obtain
 an error free transformation for the division. ...
 This means that the computed approximation is as good
 as we can expect in the working precision."

-- http://perso.ens-lyon.fr/nicolas.louvet/LaLo05.pdf

"While the sqrt algorithm is not strictly an
 errorfree transformation, it is known to be reliable
 and is recommended for general use."

-- Augmented precision square roots, 2-D norms and
   discussion on correctly reounding xsqrt(x^2 + y^2)
   by Nicolas Brisebarre, Mioara Joldes, Erik Martin-Dorel,
      Hean-Michel Muller, Peter Kornerup

=#
