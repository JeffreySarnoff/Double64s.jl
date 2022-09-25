module Double64s

export Double64, CDouble64

using ErrorfreeArithmetic

# exported types
include("type/Double64.jl")
include("type/CDouble64.jl")

# the mechanical grease
include("support/twotuple.jl")

end  # Double64s

