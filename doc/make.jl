using Documenter
using DividedRectangles

makedocs(
    sitename = "DividedRectangles.jl",
    modules = [DividedRectangles],
    format = Documenter.HTML(prettyurls = true),
    pages = [
        "Home" => "index.md",
    ],
    deploy_config = Documenter.DeployConfig(
        target = "gh-pages",
        repo = "aero-spec/DividedRectangles.jl",
        devbranch = "main",
        folder = "docs",
    )
)
