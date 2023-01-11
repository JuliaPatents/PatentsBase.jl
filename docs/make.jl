using Documenter, PatentsBase

makedocs(
    modules = [PatentsBase],
    sitename = "PatentsBase.jl",
    format = Documenter.HTML(; prettyurls = get(ENV, "CI", nothing) == "true")
)

deploydocs(
    repo = "github.com/JuliaPatents/PatentsBase.jl.git",
    devbranch = "main"
)
