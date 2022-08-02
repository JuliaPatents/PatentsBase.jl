using PatentsBase
using Documenter

DocMeta.setdocmeta!(PatentsBase, :DocTestSetup, :(using PatentsBase); recursive=true)

makedocs(;
    modules=[PatentsBase],
    authors="Jakob Hoffmann <jfb-hoffmann@hotmail.de> and contributors",
    repo="https://github.com/jfb-h/PatentsBase.jl/blob/{commit}{path}#{line}",
    sitename="PatentsBase.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://jfb-h.github.io/PatentsBase.jl",
        edit_link="master",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/jfb-h/PatentsBase.jl",
    devbranch="master",
)
