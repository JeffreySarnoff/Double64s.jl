using Documenter

makedocs(
    modules = [Double64s],
    sitename="Double64s.jl",
    authors="Jeffrey Sarnoff",
    source="src",
    clean=false,
    strict=!("strict=false" in ARGS),
    doctest=("doctest=only" in ARGS) ? :only : true,
    format=Documenter.HTML(
        # Use clean URLs, unless built as a "local" build
        prettyurls=!("local" in ARGS),
        highlights=["yaml"],
        ansicolor=true,
    ),
    pages=[
        "Overview" => "index.md",
        "Basic Use" => Any[
            "The Types" => "types.md",
        ],
        "Helpful Extras" => "extras.md",
        "Technical Notes" => Any[
            "Example from The Julia Docs" => "technical/exampleSIMDandC.md",
            "Provisioning for SIMD" => "technical/provisioning.md",
        ],
    ]
)

#=
Deploy docs to Github pages.
=#
Documenter.deploydocs(
    branch = "gh-pages",
    target = "build",
    deps = nothing,
    make = nothing,
    repo = "github.com/JeffreySarnoff/Double64s.jl.git",
)
