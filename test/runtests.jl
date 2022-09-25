using Double64s, Test

@testset "Double64" begin
    include("type/Double64.jl")
end

@testset "CDouble64" begin
    include("type/CDouble64.jl")
end
