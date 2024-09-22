# Algorithm 
 
The divided rectangles algorithm, or DIRECT (for DIvided RECTangles), incrementally refines a retangular partition of the design space. The refinement is driven a heuristic that involves reasoning about potential Lipschitz constants.

---
### Key Concepts of the DIRECT Algorithm

1. **Division of Search Space**:
   
   - The algorithm begins by treating the entire feasible region as a single hyper-rectangle.
   - The search space is normalized to the unit hypercube to avoid oversensitivity to dimensions with larger domains. If minimizing $f(x)$ in the interval between lower and upper ranges $a$ and $b$, DIRECT will instead minimize:
  
  ```math
   g(\mathbf{x}) = f(\mathbf{x} \odot (\mathbf{b} - \mathbf{a}) + \mathbf{a})
```

After finding the minimum $x^*$ of $g$, the minimum of $f$ is

```math
\mathbf{x}^* \odot (\mathbf{b} - \mathbf{a}) + \mathbf{a}
```
---

- The figure below shows DIRECT method after 16 iterations on the Branin function. The cells are much denser around the minima of the Branin function because the DIRECT method is designed to increase resolution in promising regions.

![page_11](https://github.com/user-attachments/assets/b833bedd-41aa-40c5-a27f-26188a171797)

---

2. **Function Evaluation**:
   - The function is evaluated at the center of each hyper-rectangle.
   - Each interval has a center $c^{(i)}$  and an associated objective function value $f(c^{(i)})$, as well as a radius $r^{(i)}$, which is the distance from the center to a vertex.

3. **Selection of Potentially Optimal Rectangles**:
   - After evaluation, the algorithm identifies potentially optimal rectangles. A rectangle is considered potentially optimal if it could contain the global minimum based on the evaluations performed so far.

4. **Lipschitz Lower Bound**:
   - The Lipschitz lower bound for an interval is a circular cone extending downward from its center $c^{(i)}$
   
```math
f(\mathbf{x}) \geq f(\mathbf{c}^{(i)}) - \ell \|\mathbf{x} - \mathbf{c}^{(i)}\|_2
```
   - This lower bound is constrained by the extents of the interval, and its lowest value is achieved at the vertices, which are all a distance $r^{(i)}$ from the center.
     
```math
f(c^{(i)}) - \ell r^{(i)}
```
---

- The left plot shows the intervals for the DIRECT method after 5 iterations on the Branin function. The right plot shows the interval objective function values versus their radii, which is useful for identifying intervals to split with further evaluations.

![page_12](https://github.com/user-attachments/assets/34da1f5e-c983-45cc-8b6c-531184d4b756)

- The left plot shows the Lipschitz lowerbounds constructed for the DIRECT intervals using the Lipschitz constant = 200, and highlights one interval. The right plot shows how the minimum value for the lowerbound within the highlighted interval is the same as the x-intercept for a line of slope passing through that interval’s $(r, f(c))$ point.

![page_13](https://github.com/user-attachments/assets/f023e6b0-ee8a-48fb-a8b6-c1b68d819377)

- The left plot continues to show the Lipschitz lowerbounds constructed for the DIRECT intervals using the Lipschitz constant = 200, but now highlights the interval containing the lowest value. The right plot shows how the lowest lowerbound for a given Lipschitz constant is the one with the lowest x-intercept in the right-hand plot.

![page_14](https://github.com/user-attachments/assets/7df39f70-2ef2-4eaa-a5de-54f93d21e653)

---

5. **Recursive Division**:
   - The selected rectangles are further divided, splitting into thirds along the axis directions. The order in which dimensions are split matters; lower function evaluations receive larger sub-rectangles. The process continues recursively, refining the search by focusing on the most promising regions.

6. **Convex Hull**:
   - The DIRECT method selects all intervals for which a Lipschitz constant exists such that their lower bounds have minimal value. These intervals form a piecewise-linear boundary along the lower-right of the $(r, f(c))$ space.

---

- The left plot shows the split intervals identified for this iteration of DIRECT on the Branin function. The right plot shows the lower-right convex hull formed by these split intervals in $(r, f(c))$ space.

![page_15](https://github.com/user-attachments/assets/5142788b-814e-4221-b50f-1746672278df)

---

## Splitting Intervals

When splitting a region without equal side lengths, only the longest dimensions are split. Splitting proceeds on these dimensions in the same manner as with a hypercube. The width in a given dimension depends on how many times that dimension has been split. Since DIRECT always splits axis directions by thirds, a dimension
that has been split d times will have a width of $3^−d$. If we have $n$ dimensions and track how many times each dimension of a given interval has been split in a vector $d$, then the radius of that interval is

```math
r = \left\|\left[ \frac{1}{2 \cdot 3^{-d_1}}, \dots, \frac{1}{2 \cdot 3^{-d_n}} \right]\right\|_2
```
---
- **Interval splitting in multiple dimensions for DIRECT** requires choosing an ordering for the split dimensions:

  ![page_16](https://github.com/user-attachments/assets/962993d9-372a-4733-9d1f-0260cdacdff1)

- **DIRECT will only split the longest dimensions of intervals**. The algorithm only divides intervals larger than a minimum radius. This minimum radius prevents inefficient function evaluations very close to existing points:

  ![page_17](https://github.com/user-attachments/assets/99caea66-02b5-4371-90e2-69305c035ddf)


---
## Practical Implementations: 

- Struct `DirectRectangle`:

```julia
   struct DirectRectangle
    c  # center point
    y  # center point value
    d  # number of divisions per dimension
    r  # the radius of the interval
end
```

- `direct` Function:

```julia
function direct(f, a, b, k_max, r_min)
    g = x -> f(x .* (b - a) + a)  # evaluate within unit hypercube
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
    return c_best .* (b - a) + a  # from unit hypercube
end
```
- `is_ccw` Function:
   
```julia
function is_ccw(a, b, c)
    return a.r * (b.y - c.y) - a.y * (b.r - c.r) + (b.r * c.y - b.y * c.r) < 1e-6
end
```
- `get_split_intervals`Function

```julia
function get_split_intervals(□s, r_min)
    hull = DirectRectangle[]
    sort!(□s, by = □ -> (□.r, □.y))
    for □ in □s
        if length(hull) >= 1 && □.r == hull[end].r
            continue  # Repeated r values cannot be improvements
        end
        if length(hull) >= 1 && □.y ≤ hull[end].y
            pop!(hull)  # Remove the last point if the new one is better
        end
        if length(hull) >= 2 && is_ccw(hull[end-1], hull[end], □)
            pop!(hull)
        end
        push!(hull, □)
    end
    filter!(□ -> □.r ≥ r_min, hull)  # Only split intervals larger than the minimum radius
    return hull
end
```
-  `split_interval` Function:

```julia
function split_interval(□, g)
    c, n, d_min, d = □.c, length(□.c), minimum(□.d), copy(□.d)
    dirs, δ = findall(d .== d_min), 3.0^(-d_min-1)
    Cs = [(c + δ*basis(i, n), c - δ*basis(i, n)) for i in dirs]
    Ys = [(g(C[1]), g(C[2])) for C in Cs]
    minvals = [min(Y[1], Y[2]) for Y in Ys]
    □s = DirectRectangle[]
    for j in sortperm(minvals)
        d[dirs[j]] += 1  # Increment the number of splits
        C, Y, r = Cs[j], Ys[j], norm(0.5 * 3.0.^(-d))
        push!(□s, DirectRectangle(C[1], Y[1], copy(d), r))
        push!(□s, DirectRectangle(C[2], Y[2], copy(d), r))
    end
    r = norm(0.5 * 3.0.^(-d))
    push!(□s, DirectRectangle(c, □.y, d, r))
    return □s
end
```
---

### Strengths of the DIRECT Algorithm
The strength of the DIRECT algorithm lies in its ability to systematically explore the entire search space while focusing on the most promising areas. This systematic coverage helps the algorithm escape local minima, making it particularly effective for objective functions with multiple local minima.
By not requiring the Lipschitz constant, the DIRECT algorithm is adaptable to various optimization problems, including those where the smoothness of the objective function is not well understood.

