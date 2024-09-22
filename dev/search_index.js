var documenterSearchIndex = {"docs":
[{"location":"credits/#Credits","page":"Credits","title":"Credits","text":"","category":"section"},{"location":"credits/","page":"Credits","title":"Credits","text":"Contributors to this package include Anshrin Srivastava, Mykel Kochenderfer, Dylan Asmar, and Tim Wheeler.","category":"page"},{"location":"usage/#Usage","page":"Usage","title":"Usage","text":"","category":"section"},{"location":"usage/","page":"Usage","title":"Usage","text":"To use the DividedRectangles module, start your code with:","category":"page"},{"location":"usage/","page":"Usage","title":"Usage","text":"using DividedRectangles","category":"page"},{"location":"usage/","page":"Usage","title":"Usage","text":"","category":"page"},{"location":"usage/#Core-Functions","page":"Usage","title":"Core Functions","text":"","category":"section"},{"location":"usage/#optimize","page":"Usage","title":"optimize","text":"","category":"section"},{"location":"usage/","page":"Usage","title":"Usage","text":"The optimize function is the primary function of the DividedRectangles module. It implements the DIRECT algorithm to find the minimum of a given objective function within specified bounds.","category":"page"},{"location":"usage/","page":"Usage","title":"Usage","text":"To use the optimize function with a custom mathematical function:","category":"page"},{"location":"usage/","page":"Usage","title":"Usage","text":"using DividedRectangles\n\n# Define the objective function\nf(x) = dot([1.0, 2.0, 3.0], x)  # Example objective function with coefficients\n\n# Set the search bounds\na = [0.0, 0.0, 0.0]\nb = [1.0, 1.0, 1.0]\n\n# Call the optimization function\nresult = optimize(f, a, b)\n\nprintln(\"Best design found: \", result)\n","category":"page"},{"location":"usage/","page":"Usage","title":"Usage","text":"Arguments:","category":"page"},{"location":"usage/","page":"Usage","title":"Usage","text":"f: The objective function to be minimized.\na: Vector of lower bounds for the search space.\nb: Vector of upper bounds for the search space.\nmax_iterations: (Optional) The maximum number of iterations (default: 100).\nmin_radius: (Optional) The minimum radius of hyper-rectangles (default: 1e-5).","category":"page"},{"location":"usage/","page":"Usage","title":"Usage","text":"Returns: ","category":"page"},{"location":"usage/","page":"Usage","title":"Usage","text":"The best design 𝑥 found by DIRECT.","category":"page"},{"location":"usage/","page":"Usage","title":"Usage","text":"","category":"page"},{"location":"usage/#Example:-Multivariate-Optimization","page":"Usage","title":"Example: Multivariate Optimization","text":"","category":"section"},{"location":"usage/","page":"Usage","title":"Usage","text":"The following example shows how to optimize a multivariate function using the DIRECT algorithm:","category":"page"},{"location":"usage/","page":"Usage","title":"Usage","text":"using DividedRectangles\n\n# Define the objective function\nf(x) = x[1]^2 + x[2]^2 + 3 * sin(5 * x[1]) + 2 * cos(3 * x[2])\n\n# Set the search bounds\na = [-2.0, -2.0]\nb = [2.0, 2.0]\n\n# Optimize\nresult = DividedRectangles.optimize(f, a, b)\n\nprintln(\"Best design found: \", result)","category":"page"},{"location":"usage/","page":"Usage","title":"Usage","text":"","category":"page"},{"location":"usage/#Parameters","page":"Usage","title":"Parameters","text":"","category":"section"},{"location":"usage/","page":"Usage","title":"Usage","text":"f: This is the objective function to minimize. Should be an operation that accepts a vector of Float64 values.\na: Vector representing the lower bounds of the search space.\nb: Vector representing the upper bounds of the search space.\nmax_iterations:  Maximum number of iterations for the optimization (default: 100).\nmin_radius: Minimum size of hyper-rectangles (default: 1e-5).","category":"page"},{"location":"usage/","page":"Usage","title":"Usage","text":"","category":"page"},{"location":"usage/#Advanced-Usage","page":"Usage","title":"Advanced Usage","text":"","category":"section"},{"location":"usage/#Fine-Tuning-Optimization:","page":"Usage","title":"Fine-Tuning Optimization:","text":"","category":"section"},{"location":"usage/","page":"Usage","title":"Usage","text":"The optimize function offers several parameters for fine-tuning the optimization process:","category":"page"},{"location":"usage/","page":"Usage","title":"Usage","text":"max_iterations: Sets the maximum number of iterations. Increasing this value can improve accuracy but requires more computational time.\nmin_radius: Specifies the minimum size of hyper-rectangles to control the granularity of the search.","category":"page"},{"location":"usage/","page":"Usage","title":"Usage","text":"result = DividedRectangles.optimize(f, a, b, max_iterations=500, min_radius=1e-6)","category":"page"},{"location":"algorithm/#Algorithm","page":"Algorithm","title":"Algorithm","text":"","category":"section"},{"location":"algorithm/","page":"Algorithm","title":"Algorithm","text":"The divided rectangles algorithm, or DIRECT (for DIvided RECTangles), incrementally refines a retangular partition of the design space. The refinement is driven a heuristic that involves reasoning about potential Lipschitz constants.","category":"page"},{"location":"algorithm/","page":"Algorithm","title":"Algorithm","text":"","category":"page"},{"location":"algorithm/#Key-Concepts-of-the-DIRECT-Algorithm","page":"Algorithm","title":"Key Concepts of the DIRECT Algorithm","text":"","category":"section"},{"location":"algorithm/","page":"Algorithm","title":"Algorithm","text":"Division of Search Space:\nThe algorithm begins by treating the entire feasible region as a single hyper-rectangle.\nThe search space is normalized to the unit hypercube to avoid oversensitivity to dimensions with larger domains. If minimizing f(x) in the interval between lower and upper ranges a and b, DIRECT will instead minimize:","category":"page"},{"location":"algorithm/","page":"Algorithm","title":"Algorithm","text":"   g(mathbfx) = f(mathbfx odot (mathbfb - mathbfa) + mathbfa)","category":"page"},{"location":"algorithm/","page":"Algorithm","title":"Algorithm","text":"After finding the minimum x^* of g, the minimum of f is","category":"page"},{"location":"algorithm/","page":"Algorithm","title":"Algorithm","text":"mathbfx^* odot (mathbfb - mathbfa) + mathbfa","category":"page"},{"location":"algorithm/","page":"Algorithm","title":"Algorithm","text":"","category":"page"},{"location":"algorithm/","page":"Algorithm","title":"Algorithm","text":"The figure below shows DIRECT method after 16 iterations on the Branin function. The cells are much denser around the minima of the Branin function because the DIRECT method is designed to increase resolution in promising regions.","category":"page"},{"location":"algorithm/","page":"Algorithm","title":"Algorithm","text":"(Image: page_11)","category":"page"},{"location":"algorithm/","page":"Algorithm","title":"Algorithm","text":"","category":"page"},{"location":"algorithm/","page":"Algorithm","title":"Algorithm","text":"Function Evaluation:\nThe function is evaluated at the center of each hyper-rectangle.\nEach interval has a center c^(i)  and an associated objective function value f(c^(i)), as well as a radius r^(i), which is the distance from the center to a vertex.\nSelection of Potentially Optimal Rectangles:\nAfter evaluation, the algorithm identifies potentially optimal rectangles. A rectangle is considered potentially optimal if it could contain the global minimum based on the evaluations performed so far.\nLipschitz Lower Bound:\nThe Lipschitz lower bound for an interval is a circular cone extending downward from its center c^(i)","category":"page"},{"location":"algorithm/","page":"Algorithm","title":"Algorithm","text":"f(mathbfx) geq f(mathbfc^(i)) - ell mathbfx - mathbfc^(i)_2","category":"page"},{"location":"algorithm/","page":"Algorithm","title":"Algorithm","text":"This lower bound is constrained by the extents of the interval, and its lowest value is achieved at the vertices, which are all a distance r^(i) from the center.","category":"page"},{"location":"algorithm/","page":"Algorithm","title":"Algorithm","text":"f(c^(i)) - ell r^(i)","category":"page"},{"location":"algorithm/","page":"Algorithm","title":"Algorithm","text":"","category":"page"},{"location":"algorithm/","page":"Algorithm","title":"Algorithm","text":"The left plot shows the intervals for the DIRECT method after 5 iterations on the Branin function. The right plot shows the interval objective function values versus their radii, which is useful for identifying intervals to split with further evaluations.","category":"page"},{"location":"algorithm/","page":"Algorithm","title":"Algorithm","text":"(Image: page_12)","category":"page"},{"location":"algorithm/","page":"Algorithm","title":"Algorithm","text":"The left plot shows the Lipschitz lowerbounds constructed for the DIRECT intervals using the Lipschitz constant = 200, and highlights one interval. The right plot shows how the minimum value for the lowerbound within the highlighted interval is the same as the x-intercept for a line of slope passing through that interval’s (r f(c)) point.","category":"page"},{"location":"algorithm/","page":"Algorithm","title":"Algorithm","text":"(Image: page_13)","category":"page"},{"location":"algorithm/","page":"Algorithm","title":"Algorithm","text":"The left plot continues to show the Lipschitz lowerbounds constructed for the DIRECT intervals using the Lipschitz constant = 200, but now highlights the interval containing the lowest value. The right plot shows how the lowest lowerbound for a given Lipschitz constant is the one with the lowest x-intercept in the right-hand plot.","category":"page"},{"location":"algorithm/","page":"Algorithm","title":"Algorithm","text":"(Image: page_14)","category":"page"},{"location":"algorithm/","page":"Algorithm","title":"Algorithm","text":"","category":"page"},{"location":"algorithm/","page":"Algorithm","title":"Algorithm","text":"Recursive Division:\nThe selected rectangles are further divided, splitting into thirds along the axis directions. The order in which dimensions are split matters; lower function evaluations receive larger sub-rectangles. The process continues recursively, refining the search by focusing on the most promising regions.\nConvex Hull:\nThe DIRECT method selects all intervals for which a Lipschitz constant exists such that their lower bounds have minimal value. These intervals form a piecewise-linear boundary along the lower-right of the (r f(c)) space.","category":"page"},{"location":"algorithm/","page":"Algorithm","title":"Algorithm","text":"","category":"page"},{"location":"algorithm/","page":"Algorithm","title":"Algorithm","text":"The left plot shows the split intervals identified for this iteration of DIRECT on the Branin function. The right plot shows the lower-right convex hull formed by these split intervals in (r f(c)) space.","category":"page"},{"location":"algorithm/","page":"Algorithm","title":"Algorithm","text":"(Image: page_15)","category":"page"},{"location":"algorithm/","page":"Algorithm","title":"Algorithm","text":"","category":"page"},{"location":"algorithm/#Splitting-Intervals","page":"Algorithm","title":"Splitting Intervals","text":"","category":"section"},{"location":"algorithm/","page":"Algorithm","title":"Algorithm","text":"When splitting a region without equal side lengths, only the longest dimensions are split. Splitting proceeds on these dimensions in the same manner as with a hypercube. The width in a given dimension depends on how many times that dimension has been split. Since DIRECT always splits axis directions by thirds, a dimension that has been split d times will have a width of 3^d. If we have n dimensions and track how many times each dimension of a given interval has been split in a vector d, then the radius of that interval is","category":"page"},{"location":"algorithm/","page":"Algorithm","title":"Algorithm","text":"r = leftleft frac12 cdot 3^-d_1 dots frac12 cdot 3^-d_n rightright_2","category":"page"},{"location":"algorithm/","page":"Algorithm","title":"Algorithm","text":"","category":"page"},{"location":"algorithm/","page":"Algorithm","title":"Algorithm","text":"Interval splitting in multiple dimensions for DIRECT requires choosing an ordering for the split dimensions:\n(Image: page_16)\nDIRECT will only split the longest dimensions of intervals. The algorithm only divides intervals larger than a minimum radius. This minimum radius prevents inefficient function evaluations very close to existing points:\n(Image: page_17)","category":"page"},{"location":"algorithm/","page":"Algorithm","title":"Algorithm","text":"","category":"page"},{"location":"algorithm/#Practical-Implementations:","page":"Algorithm","title":"Practical Implementations:","text":"","category":"section"},{"location":"algorithm/","page":"Algorithm","title":"Algorithm","text":"Struct DirectRectangle:","category":"page"},{"location":"algorithm/","page":"Algorithm","title":"Algorithm","text":"   struct DirectRectangle\n    c  # center point\n    y  # center point value\n    d  # number of divisions per dimension\n    r  # the radius of the interval\nend","category":"page"},{"location":"algorithm/","page":"Algorithm","title":"Algorithm","text":"direct Function:","category":"page"},{"location":"algorithm/","page":"Algorithm","title":"Algorithm","text":"function direct(f, a, b, k_max, r_min)\n    g = x -> f(x .* (b - a) + a)  # evaluate within unit hypercube\n    n = length(a)\n    c = fill(0.5, n)\n    □s = [DirectRectangle(c, g(c), fill(0, n), sqrt(0.5^n))]\n    c_best = c\n    for k in 1 : k_max\n        □s_split = get_split_intervals(□s, r_min)\n        setdiff!(□s, □s_split)\n        for □_split in □s_split\n            append!(□s, split_interval(□_split, g))\n        end\n        c_best = □s[findmin(□.y for □ in □s)[2]].c\n    end\n    return c_best .* (b - a) + a  # from unit hypercube\nend","category":"page"},{"location":"algorithm/","page":"Algorithm","title":"Algorithm","text":"is_ccw Function:","category":"page"},{"location":"algorithm/","page":"Algorithm","title":"Algorithm","text":"function is_ccw(a, b, c)\n    return a.r * (b.y - c.y) - a.y * (b.r - c.r) + (b.r * c.y - b.y * c.r) < 1e-6\nend","category":"page"},{"location":"algorithm/","page":"Algorithm","title":"Algorithm","text":"get_split_intervalsFunction","category":"page"},{"location":"algorithm/","page":"Algorithm","title":"Algorithm","text":"function get_split_intervals(□s, r_min)\n    hull = DirectRectangle[]\n    sort!(□s, by = □ -> (□.r, □.y))\n    for □ in □s\n        if length(hull) >= 1 && □.r == hull[end].r\n            continue  # Repeated r values cannot be improvements\n        end\n        if length(hull) >= 1 && □.y ≤ hull[end].y\n            pop!(hull)  # Remove the last point if the new one is better\n        end\n        if length(hull) >= 2 && is_ccw(hull[end-1], hull[end], □)\n            pop!(hull)\n        end\n        push!(hull, □)\n    end\n    filter!(□ -> □.r ≥ r_min, hull)  # Only split intervals larger than the minimum radius\n    return hull\nend","category":"page"},{"location":"algorithm/","page":"Algorithm","title":"Algorithm","text":"split_interval Function:","category":"page"},{"location":"algorithm/","page":"Algorithm","title":"Algorithm","text":"function split_interval(□, g)\n    c, n, d_min, d = □.c, length(□.c), minimum(□.d), copy(□.d)\n    dirs, δ = findall(d .== d_min), 3.0^(-d_min-1)\n    Cs = [(c + δ*basis(i, n), c - δ*basis(i, n)) for i in dirs]\n    Ys = [(g(C[1]), g(C[2])) for C in Cs]\n    minvals = [min(Y[1], Y[2]) for Y in Ys]\n    □s = DirectRectangle[]\n    for j in sortperm(minvals)\n        d[dirs[j]] += 1  # Increment the number of splits\n        C, Y, r = Cs[j], Ys[j], norm(0.5 * 3.0.^(-d))\n        push!(□s, DirectRectangle(C[1], Y[1], copy(d), r))\n        push!(□s, DirectRectangle(C[2], Y[2], copy(d), r))\n    end\n    r = norm(0.5 * 3.0.^(-d))\n    push!(□s, DirectRectangle(c, □.y, d, r))\n    return □s\nend","category":"page"},{"location":"algorithm/","page":"Algorithm","title":"Algorithm","text":"","category":"page"},{"location":"algorithm/#Strengths-of-the-DIRECT-Algorithm","page":"Algorithm","title":"Strengths of the DIRECT Algorithm","text":"","category":"section"},{"location":"algorithm/","page":"Algorithm","title":"Algorithm","text":"The strength of the DIRECT algorithm lies in its ability to systematically explore the entire search space while focusing on the most promising areas. This systematic coverage helps the algorithm escape local minima, making it particularly effective for objective functions with multiple local minima. By not requiring the Lipschitz constant, the DIRECT algorithm is adaptable to various optimization problems, including those where the smoothness of the objective function is not well understood.","category":"page"},{"location":"installation/#Installation","page":"Installation","title":"Installation","text":"","category":"section"},{"location":"installation/","page":"Installation","title":"Installation","text":"To install the package, start Julia and run the following command:","category":"page"},{"location":"installation/","page":"Installation","title":"Installation","text":"using Pkg\nPkg.add(url=\"https://github.com/sisl/DividedRectangles.jl\")\n","category":"page"},{"location":"#DividedRectangles.jl","page":"Home","title":"DividedRectangles.jl","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"(Image: CI) (Image: Documentation Status) (Image: codecov) –-","category":"page"},{"location":"","page":"Home","title":"Home","text":"Important Note: The content in this package is borrowed from Chapter 7, \"Direct Methods,\" of the forthcoming second edition of \"Algorithms for Optimization\" by Mykel Kochenderfer and Tim Wheeler.","category":"page"},{"location":"","page":"Home","title":"Home","text":"DividedRectangles.jl provides an implementation of the DIRECT (DIvided RECTangles) algorithm for global optimization. The DIRECT algorithm is particularly useful for optimizing functions where the Lipschitz constant is unknown. This package allows users to perform both univariate and multivariate optimization efficiently.","category":"page"},{"location":"","page":"Home","title":"Home","text":"","category":"page"},{"location":"","page":"Home","title":"Home","text":"Example Objective Function: As an example of an objective function, consider:","category":"page"},{"location":"","page":"Home","title":"Home","text":"f(x) = dot(coeffs, x)","category":"page"},{"location":"","page":"Home","title":"Home","text":"where:","category":"page"},{"location":"","page":"Home","title":"Home","text":"x: represents the variables.\ncoeffs: represents the coefficients corresponding to each variable.","category":"page"},{"location":"","page":"Home","title":"Home","text":"This is just one possible objective function that could be optimized using the DIRECT algorithm. The algorithm works by dividing the search space into smaller rectangles and evaluating the function at specific points within these rectangles to find the optimal solution.","category":"page"},{"location":"","page":"Home","title":"Home","text":"","category":"page"},{"location":"","page":"Home","title":"Home","text":"This documentation provides detailed usage examples, theoretical background, and advanced customization options to help you get the most out of DividedRectangles.jl.","category":"page"}]
}
