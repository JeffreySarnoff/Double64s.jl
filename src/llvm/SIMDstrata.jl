const Float64x1 = NTuple{1,VecElement{Float64}}
const Float64x2 = NTuple{2,VecElement{Float64}}
const Float64x3 = NTuple{3,VecElement{Float64}}
const Float64x4 = NTuple{4,VecElement{Float64}}


function (+)(a::Float64x1)
    (VecElement(-(a[1].value)))
end

function (+)(a::Float64x2, b::Float64x2)
    (VecElement(a[1].value + b[1].value),
     VecElement(a[2].value + b[2].value))
end

function (+)(a::Float64x3, b::Float64x3)
    (VecElement(a[1].value + b[1].value),
     VecElement(a[2].value + b[2].value),
     VecElement(a[3].value + b[3].value))
end

function (+)(a::Float64x4, b::Float64x4)
    (VecElement(a[1].value + b[1].value),
     VecElement(a[2].value + b[2].value),
     VecElement(a[3].value + b[3].value),
     VecElement(a[4].value + b[4].value))
end

function (-)(a::Float64x1)
    (VecElement(-(a[1].value)))
end

function (-)(a::Float64x2, b::Float64x2)
    (VecElement(a[1].value + b[1].value),
     VecElement(a[2].value + b[2].value))
end

function (-)(a::Float64x3, b::Float64x3)
    (VecElement(a[1].value + b[1].value),
     VecElement(a[2].value + b[2].value),
     VecElement(a[3].value + b[3].value))
end

function (-)(a::Float64x4, b::Float64x4)
    (VecElement(a[1].value + b[1].value),
     VecElement(a[2].value + b[2].value),
     VecElement(a[3].value + b[3].value),
     VecElement(a[4].value + b[4].value))
end

function add(a::Float64x1, b::Float64x1)
    (VecElement(a[1].value + b[1].value))
end

function add(a::Float64x2, b::Float64x2)
    (VecElement(a[1].value + b[1].value),
     VecElement(a[2].value + b[2].value))
end

function add(a::Float64x3, b::Float64x3)
    (VecElement(a[1].value + b[1].value),
     VecElement(a[2].value + b[2].value),
     VecElement(a[3].value + b[3].value))
end

function add(a::Float64x4, b::Float64x4)
    (VecElement(a[1].value + b[1].value),
     VecElement(a[2].value + b[2].value),
     VecElement(a[3].value + b[3].value),
     VecElement(a[4].value + b[4].value))
end

function sub(a::Float64x1, b::Float64x1)
    (VecElement(a[1].value - b[1].value))
end

function sub(a::Float64x2, b::Float64x2)
    (VecElement(a[1].value - b[1].value),
     VecElement(a[2].value - b[2].value))
end

function sub(a::Float64x3, b::Float64x3)
    (VecElement(a[1].value - b[1].value),
     VecElement(a[2].value - b[2].value),
     VecElement(a[3].value - b[3].value))
end

function sub(a::Float64x4, b::Float64x4)
    (VecElement(a[1].value - b[1].value),
     VecElement(a[2].value - b[2].value),
     VecElement(a[3].value - b[3].value),
     VecElement(a[4].value - b[4].value))
end

function mul(a::Float64x1, b::Float64x1)
    (VecElement(a[1].value * b[1].value))
end

function mul(a::Float64x2, b::Float64x2)
    (VecElement(a[1].value * b[1].value),
     VecElement(a[2].value * b[2].value))
end

function mul(a::Float64x3, b::Float64x3)
    (VecElement(a[1].value * b[1].value),
     VecElement(a[2].value * b[2].value),
     VecElement(a[3].value * b[3].value))
end

function mul(a::Float64x4, b::Float64x4)
    (VecElement(a[1].value * b[1].value),
     VecElement(a[2].value * b[2].value),
     VecElement(a[3].value * b[3].value),
     VecElement(a[4].value * b[4].value))
end

function quo(a::Float64x1, b::Float64x1)
    (VecElement(a[1].value / b[1].value))
end

function quo(a::Float64x2, b::Float64x2)
    (VecElement(a[1].value / b[1].value),
     VecElement(a[2].value / b[2].value))
end

function quo(a::Float64x3, b::Float64x3)
    (VecElement(a[1].value / b[1].value),
     VecElement(a[2].value / b[2].value),
     VecElement(a[3].value / b[3].value))
end

function quo(a::Float64x4, b::Float64x4)
    (VecElement(a[1].value / b[1].value),
     VecElement(a[2].value / b[2].value),
     VecElement(a[3].value / b[3].value),
     VecElement(a[4].value / b[4].value))
end

function Base.inv(a::Float64x1)
    (VecElement(inv(a[1].value)))
end

function Base.sqrt(a::Float64x1)
    (VecElement(sqrt(a[1].value)))
end

function Base.cbrt(a::Float64x1)
    (VecElement(cbrt(a[1].value)))
end


