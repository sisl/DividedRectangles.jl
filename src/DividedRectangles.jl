module DividedRectangles

export optimize, direct

"""
A structure for store information about each hyperrectangular interval.
"""
struct DirectRectangle
    c::Vector{Float64} # center point
    y::Float64         # center point value   
    d::Vector{Int}     # number of divisions per dimension
    r::Float64         # interval radius
end

"""
A helper function that determines whether a→b→c is counter-clockwise in (r,y) space.
"""
function is_ccw(a::DirectRectangle, b::DirectRectangle, c::DirectRectangle)
    return a.r*(b.y-c.y)-a.y*(b.r-c.r)+(b.r*c.y-b.y*c.r) < 1e-6
end

"""
A helper function that returns a basis vector with a single 1 entry in an otherwise zero vector.
"""
basis(i, n) = [k == i ? 1.0 : 0.0 for k in 1 : n]

"""
A routine for obtaining the split intervals from a given list of intervals and a minimum radius.
The potentially optimal intervals form a lower-right convex hull in r and y.
"""
function get_split_intervals(□s::Vector{DirectRectangle}, r_min::Float64)
    hull = DirectRectangle[]
    # Sort the rects by increasing r, then by increasing y
    sort!(□s, by = □ -> (□.r, □.y))
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
Split the given interval, where g is the objective function in the unit hypercube.
This method returns a list of the resulting smaller intervals.
"""
function split_interval(□, g)
    c, n, d_min, d = □.c, length(□.c), minimum(□.d), copy(□.d)
    dirs, δ = findall(d .== d_min), 3.0^(-d_min-1)
    # Sample the objective function in all split directions,
    # and track the minimum value in each axis.
    Cs = [(c + δ*basis(i,n), c - δ*basis(i,n)) for i in dirs]
    Ys = [(g(C[1]), g(C[2])) for C in Cs]
    minvals = [min(Y[1], Y[2]) for Y in Ys]

    # Split the axes in order by increasing minimum value.
    □s = DirectRectangle[]
    for j in sortperm(minvals)
        d[dirs[j]] += 1 # increment the number of splits
        C, Y, r = Cs[j], Ys[j], norm(0.5*3.0.^(-d))
        push!(□s, DirectRectangle(C[1], Y[1], copy(d), r))
        push!(□s, DirectRectangle(C[2], Y[2], copy(d), r))
    end
    r = norm(0.5*3.0.^(-d))
    push!(□s, DirectRectangle(c, □.y, d, r))
    return □s
end

"""
An implementation of DIRECT that runs for the given number of iterations and 
then returns all hyperrectangular intervals.
"""
function direct(f, a::Vector{Float64}, b::Vector{Float64};
    max_iterations::Int = 100, min_radius::Float64 = 1e-5)
    
    g = x -> f(x.*(b-a) + a) # evaluate within unit hypercube

    n = length(a)
    c = fill(0.5, n)
    □s = [DirectRectangle(c, g(c), fill(0, n), sqrt(0.5^n))]

    for k in 1 : max_iterations
        □s_split = get_split_intervals(□s, min_radius)
        setdiff!(□s, □s_split)
        for □_split in □s_split
            append!(□s, split_interval(□_split, g))
        end
    end

    return □s
end

"""
The primary method provided by DividedRectangles.jl, which is used to
optimize an objective function and return the best design found.
"""
function optimize(f, a::Vector{Float64}, b::Vector{Float64};
        max_iterations::Int = 100, min_radius::Float64 = 1e-5)
    □s = direct(f, a, b, max_iterations=max_iterations, min_radius=min_radius)
    c_best = □s[findmin(□.y for □ in □s)[2]].c
    return c_best.*(b-a) + a # from unit hypercube
end

end # end module
