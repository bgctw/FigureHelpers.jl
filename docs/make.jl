using Documenter
using FigureHelpers

push!(LOAD_PATH,"../src/")
makedocs(sitename="FigureHelpers.jl",
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
