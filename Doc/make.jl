using Documenter, DividedRectangles

makedocs(
    sitename = "DividedRectangles.jl Documentation",
    modules = [DividedRectangles],
    format = Documenter.HTML(prettyurls=true),
    pages = [
        "Home" => "index.md",
        "Installation" => "installation.md",
        "Usage" => "usage.md",
        "Theory" => "theory.md",
        "Advanced Usage" => "advanced_usage.md",
        "Visualization" => "visualization.md",
        "Credits" => "credits.md"
    ]
)

deploydocs(
    repo = "github.com/sisl/DividedRectangles.jl.git",  
    branch = "gh-pages",  
    target = "build" 
)

