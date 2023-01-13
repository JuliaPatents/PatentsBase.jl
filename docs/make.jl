using Documenter, PatentsBase

makedocs(
    modules = [PatentsBase],
    sitename = "PatentsBase.jl",
    format = Documenter.HTML(; prettyurls = get(ENV, "CI", nothing) == "true"),
    pages = [
        "Home" => "index.md",
        "User Guide" => "guide.md",
        "Interface Reference" => "ref.md"
    ]
)

deploydocs(
    repo = "github.com/JuliaPatents/PatentsBase.jl.git",
    devbranch = "main"
)
