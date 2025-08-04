using Documenter
using FigureHelpers

push!(LOAD_PATH,"../src/")
makedocs(sitename="FigureHelpers.jl",
    authors="Thomas Wutzler <twutz@bgc-jena.mpg.de> and contributors",
    repo = Remotes.GitHub("bgctw", "FigureHelpers.jl"),
    # format=Documenter.HTML(;
    #     prettyurls=get(ENV, "CI", "false") == "true",
    #     canonical="https://EarthyScience.github.io/Bigleaf.jl",
    #     assets=String[],
    # ),
         doctest  = false, 
         pages = [
            "Home" => "index.md",
            "Makie" => "makie.md",
            "AoG" => "aog.md",
         ],
         #modules = [FigureHelpers],
         format = Documenter.HTML(prettyurls = false)
)
# Documenter can also automatically deploy documentation to gh-pages.
# See "Hosting Documentation" and deploydocs() in the Documenter manual
# for more information.
deploydocs(
    repo = "github.com/bgctw/FigureHelpers.jl.git",
    devbranch = "main"
)
