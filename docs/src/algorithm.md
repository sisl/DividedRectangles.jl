# Algorithms  
**Important Note**: The content below is borrowed from Chapter 7, "Direct Methods," of the forthcoming second edition of "Algorithms for Optimization" by Mykel Kochenderfer and Tim Wheeler.

The DIRECT algorithm incrementally refines a rectangular partition of the design space, using a heuristic inspired by potential Lipschitz constants to guide the refinement. This partitioning allows for global optimization by balancing exploration and exploitation of the design space. 

---

## Normalization:

To simplify the mathematics and avoid oversensitivity to dimensions with larger domains, DIRECT first normalizes the search space to be the unit hypercube.

If we are minimizing $f(x)$ in the interval between lower and upper ranges $a$ and $b$ DIRECT will instead minimize:

```math
g(\mathbf{x}) = f(\mathbf{x} \odot (\mathbf{b} - \mathbf{a}) + \mathbf{a})
```

After finding the minimum $f(x)$ of $g$, the minimum of $f$ is:

```math
\mathbf{x}^* \odot (\mathbf{b} - \mathbf{a}) + \mathbf{a}
```

---

## Partitioning the Search Space:
DIRECT maintains a partition of this unit hypercube into hyperrectangular intervals. Each interval has:

- A center $c^{(i)}$
- An associated objective function value $f(c^{(i)})$
- A radius $r^{(i)}$, which is the distance from the center to a vertex.

DIRECT begins every iteration by identifying intervals to be split with additional function evaluations. It splits the intervals for which a Lipschitz constant $\ell$ exists such that that interval contains the Lipschitz lowerbound.

---

## Splitting Intervals

DIRECT splits the identified intervals along their longest dimensions, dividing each interval into thirds. These splits refine the resolution in areas of interest, increasing accuracy near the minimum while avoiding excessive evaluations in less promising regions. The heuristic ensures that intervals are split in a way that balances the need for exploring the global space and refining local areas of interest.


## Lipschitz Lower Bound

The Lipschitz lower bound for an interval is a circular cone extending downwards from its center $c^{(i)}$:

```math
f(\mathbf{x}) \geq f(\mathbf{c}^{(i)}) - \ell \|\mathbf{x} - \mathbf{c}^{(i)}\|_2
```

This lower bound helps guide the decision of which intervals to split. The intervals for which a Lipschitz constant $\ell$ exists such that the interval contains the Lipschitz lower bound are selected for further subdivision.

---

## Potentially Optimal Intervals:

DIRECT does not rely on a fixed Lipschitz constant. Instead, it selects potentially optimal intervals—those where a Lipschitz constant \( \ell \) could exist that makes the interval contain the global minimum. The process of identifying these intervals forms a **lower-right convex hull** in \( (r, f(c)) \)-space, which guides the algorithm to split the most promising intervals.

---
## DIRECT Algorithm Implementation

This code defines the DIRECT algorithm. The algorithm outputs the best coordinate after iteratively splitting and refining hyperrectangles in the search space.

```juliaverbatim
struct DirectRectangle
    c # center point
    y # center point value
    d # number of divisions per dimension
    r # the radius of the interval
end

function direct(f, a, b, k_max, r_min)
    g = x -> f(x.*(b-a) + a) # evaluate within unit hypercube

    n = length(a)
    c = fill(0.5, n)
    □s = [DirectRectangle(c, g(c), fill(0, n), sqrt(0.5^n))]

    c_best = c
    for k in 1 : k_max
        □s_split = get_split_intervals(□s, r_min)
        setdiff!(□s, □s_split)
        for □_split in □s_split
            append!(□s, split_interval(□_split, g))
        end
        c_best = □s[findmin(□.y for □ in □s)[2]].c
    end

    return c_best.*(b-a) + a # from unit hypercube
end
```
This supporting function selects the intervals for splitting based on the radius and objective function values, maintaining a convex hull of potentially optimal intervals:

```juliaverbatim
function get_split_intervals(□s, r_min)
    hull = DirectRectangle[]
    # Sort the rects by increasing r, then by increasing y
    sort!(□s, by = □ -> (□.r, □.y))
    for □ in □s
        if length(hull) ≥ 1 && □.r == hull[end].r
            continue
        end
        if length(hull) ≥ 1 && □.y ≤ hull[end].y
            pop!(hull)
        end
        if length(hull) ≥ 2 && is_ccw(hull[end-1], hull[end], □)
            pop!(hull)
        end
        push!(hull, □)
    end
    # Only split intervals larger than the minimum radius
    filter!(□ -> □.r ≥ r_min, hull)
    return hull
end
```
This function handles the splitting of a selected interval along its axes, producing smaller intervals for further evaluation:

```juliaverbatim
function split_interval(□, g)
    c, n, d_min, d = □.c, length(□.c), minimum(□.d), copy(□.d)
    dirs, δ = findall(d .== d_min), 3.0^(-d_min-1)
    Cs = [(c + δ*basis(i,n), c - δ*basis(i,n)) for i in dirs]
    Ys = [(g(C[1]), g(C[2])) for C in Cs]
    minvals = [min(Y[1], Y[2]) for Y in Ys]

    # Split the axes in order by increasing minimum value.
    □s = DirectRectangle[]
    for j in sortperm(minvals)
        d[dirs[j]] += 1
        C, Y, r = Cs[j], Ys[j], norm(0.5*3.0.^(-d))
        push!(□s, DirectRectangle(C[1], Y[1], copy(d), r))
        push!(□s, DirectRectangle(C[2], Y[2], copy(d), r))
    end
    r = norm(0.5*3.0.^(-d))
    push!(□s, DirectRectangle(c, □.y, d, r))
    return □s
end
```
Parameters:

- `f`: the multidimensional objective function
- `a`: Vector of lower bounds for the search space.
- `b`: Vector of upper bounds for the search space.
- `k_max`: the number of iterations
- `r_min`: the minimum interval radius

