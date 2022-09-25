using Documenter

makedocs(
    modules = [Double64s],
    sitename = "Double64s.jl",
    authors = "Jeffrey Sarnoff and other contributors",
    pages  = Any[
        "Overview"                 => "index.md",
        "The Types"                => "types.md",
        "Provisioning for SIMD"    => "provisioning.md",
        ]
    )

deploydocs(
    repo = "github.com/JeffreySarnoff/Double64s.jl.git",
    target = "build"
)
