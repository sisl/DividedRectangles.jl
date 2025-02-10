# Load the required packages
using Documenter
using DividedRectangles

# Define the documentation generation process
makedocs(
    sitename = "DividedRectangles.jl",
    modules = [DividedRectangles],
    format = Documenter.HTML(),
    pages = [
        "Home" => "index.md",
        "Installation" => "installation.md",
        "Usage" => "usage.md",
        "Algorithm" => "algorithm.md",
        "Credits" => "credits.md"
    ]
)

deploydocs(
    repo = "github.com/sisl/DividedRectangles.jl.git",
    push_preview=true
)
