module DividedRectangles

using LinearAlgebra

export optimize, direct

# A default tolerance value for the is_ccw function.
const DEFAULT_CCW_TOL = 1e-6

"""
    DirectRectangle

A data structure representing a hyperrectangular interval in the normalized unit hypercube [0, 1]^n,
used by the DIRECT (DIvided RECTangles) global optimization algorithm.

# Fields
- `c::Vector{Float64}`: The center point of the interval, given as a vector in [0, 1]^n.
- `y::Float64`: The value of the objective function evaluated at the center `c`.
- `d::Vector{Int}`: The count of divisions along each dimension.
- `r::Float64`: The "radius" of the hyperrectangle, computed as `r = norm(0.5 * 3.0.^(-d))`.
"""
struct DirectRectangle
    c::Vector{Float64}
    y::Float64
    d::Vector{Int}
    r::Float64
end

"""
    is_ccw(a, b, c; tol=DEFAULT_CCW_TOL)

Determines whether the sequence of hyperrectangles `a → b → c` forms a counter-clockwise turn in the `(r, y)` space.

# Arguments
- `a::DirectRectangle, b::DirectRectangle, c::DirectRectangle`: Hyperrectangles whose `(r, y)` values are compared.
- `tol::Float64`: (Optional) Tolerance for the counter-clockwise test (default: `DEFAULT_CCW_TOL`).

# Returns
- `true` if the computed expression is less than `tol`, indicating a counter-clockwise configuration;
  otherwise, returns `false`.
"""
function is_ccw(a::DirectRectangle, b::DirectRectangle, c::DirectRectangle; tol::Float64=DEFAULT_CCW_TOL)
    return a.r * (b.y - c.y) - a.y * (b.r - c.r) + (b.r * c.y - b.y * c.r) < tol
end

"""
    basis(i, n)

Returns the `i`th standard basis vector of length `n`.
"""
basis(i, n) = [k == i ? 1.0 : 0.0 for k in 1:n]

"""
    get_split_intervals(□s, r_min)

Selects hyperrectangles from the list `□s` that are candidates for splitting.
This routine uses a convex-hull criterion in the `(r, y)` space to identify potentially optimal
intervals, then filters out any with a radius smaller than `r_min`.

# Arguments
- `□s::Vector{DirectRectangle}`: The current list of hyperrectangular intervals.
- `r_min::Float64`: The minimum allowable radius for an interval to be considered for splitting.

# Returns
- A vector of `DirectRectangle` instances that are eligible for further subdivision.
"""
function get_split_intervals(□s::Vector{DirectRectangle}, r_min::Float64)
    hull = DirectRectangle[]
    # Sort the rects by increasing r, then by increasing y
    sort!(□s, by=□ -> (□.r, □.y))
    for □ in □s
        if length(hull) ≥ 1 && □.r == hull[end].r
            # Repeated r values cannot be improvements
            continue
        end
        if length(hull) ≥ 1 && □.y ≤ hull[end].y
            # Remove the last point if the new one is better
            pop!(hull)
        end
        if length(hull) ≥ 2 && is_ccw(hull[end-1], hull[end], □)
            # Remove the last point if the new one is better
            pop!(hull)
        end
        push!(hull, □)
    end
    # Only split intervals larger than the minimum radius
    filter!(□ -> □.r ≥ r_min, hull)
    return hull
end

"""
    split_interval(□, g)

Splits the hyperrectangular interval `□` along the dimensions with the smallest number of subdivisions.
The objective function `g` is evaluated at new points corresponding to split directions. The resulting
smaller intervals are returned.

# Arguments
- `□::DirectRectangle`: The hyperrectangle to be subdivided.
- `g`: A function mapping a point in the unit hypercube to its objective function value.

# Returns
- A vector of new `DirectRectangle` instances resulting from the subdivision of `□`.
"""
function split_interval(□, g)
    c, n, d_min, d = □.c, length(□.c), minimum(□.d), copy(□.d)
    dirs, δ = findall(d .== d_min), 3.0^(-d_min - 1)
    # Sample the objective function in all split directions,
    # and track the minimum value in each axis.
    Cs = [(c + δ * basis(i, n), c - δ * basis(i, n)) for i in dirs]
    Ys = [(g(C[1]), g(C[2])) for C in Cs]
    minvals = [min(Y[1], Y[2]) for Y in Ys]

    # Split the axes in order by increasing minimum value.
    □s = DirectRectangle[]
    for j in sortperm(minvals)
        d[dirs[j]] += 1 # increment the number of splits
        C, Y, r = Cs[j], Ys[j], norm(0.5 * 3.0 .^ (-d))
        push!(□s, DirectRectangle(C[1], Y[1], copy(d), r))
        push!(□s, DirectRectangle(C[2], Y[2], copy(d), r))
    end
    r = norm(0.5 * 3.0 .^ (-d))
    push!(□s, DirectRectangle(c, □.y, d, r))
    return □s
end

"""
    direct(f, a::Vector{Float64}, b::Vector{Float64}; max_iterations::Int = 100, min_radius::Float64 = 1e-5)

Implements the DIRECT (DIvided RECTangles) algorithm to perform global optimization by iteratively subdividing
the search space. The algorithm operates in the normalized unit hypercube [0, 1]^n, where the mapping from the
original search space (given by bounds `a` and `b`) to the unit hypercube is performed on-the-fly.

# Arguments
- `f`: The objective function to be minimized. It should accept a vector of real numbers and return a scalar.
- `a::Vector{Float64}`: A vector of lower bounds for each dimension of the original search space.
- `b::Vector{Float64}`: A vector of upper bounds for each dimension of the original search space.
- `max_iterations::Int`: The maximum number of iterations to execute (default is 100).
- `min_radius::Float64`: The minimum allowed hyperrectangle radius for further subdivision (default is 1e-5).

# Returns
- A vector of `DirectRectangle` instances representing the final set of hyperrectangular intervals after the
  specified number of iterations. Each `DirectRectangle` contains:
    - `c`: the center point (in the unit hypercube),
    - `y`: the objective function value at the center,
    - `d`: the division count per dimension,
    - `r`: the computed radius of the rectangle.
"""
function direct(f, a::Vector{Float64}, b::Vector{Float64};
    max_iterations::Int=100, min_radius::Float64=1e-5)

    g = x -> f(x .* (b - a) + a) # evaluate within unit hypercube

    n = length(a)
    c = fill(0.5, n)
    □s = [DirectRectangle(c, g(c), fill(0, n), sqrt(0.5^n))]

    for k in 1:max_iterations
        □s_split = get_split_intervals(□s, min_radius)
        setdiff!(□s, □s_split)
        for □_split in □s_split
            append!(□s, split_interval(□_split, g))
        end
    end

    return □s
end

"""
    optimize(f, a::Vector{Float64}, b::Vector{Float64}; max_iterations::Int = 100, min_radius::Float64 = 1e-5)

The primary optimization routine of the DividedRectangles module. It uses the DIRECT algorithm to search for
the global minimum of the objective function `f` over a bounded search space defined by `a` and `b`.

# Arguments
- `f`: The objective function to be minimized. Must be defined for inputs in ℝⁿ.
- `a::Vector{Float64}`: A vector of lower bounds for the search space.
- `b::Vector{Float64}`: A vector of upper bounds for the search space.
- `max_iterations::Int`: (Optional) The maximum number of iterations for the DIRECT algorithm (default is 100).
- `min_radius::Float64`: (Optional) The minimum radius below which hyperrectangles are no longer subdivided (default is 1e-5).

# Returns
- A vector of `Float64` representing the best design (i.e., the point in the original search space) found
  by the DIRECT algorithm.
"""
function optimize(f, a::Vector{Float64}, b::Vector{Float64};
    max_iterations::Int=100, min_radius::Float64=1e-5)
    □s = direct(f, a, b, max_iterations=max_iterations, min_radius=min_radius)
    c_best = □s[findmin(□.y for □ in □s)[2]].c
    return c_best .* (b - a) + a # from unit hypercube
end

end # end module
