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
    ],
    assets = "assets",
    nav = [
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
    repo = "github.com/sisl/DividedRectangles.jl.git",  # Replace with your repository URL
    branch = "gh-pages",  # GitHub Pages branch
    target = "build"  # Directory to deploy
)
