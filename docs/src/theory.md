# Theory
 
The DIRECT (Divided Rectangles) algorithm is a global optimization method that does not require a known Lipschitz constant. This characteristic makes it particularly robust and versatile, applicable to a wide range of optimization problems. The algorithm operates by dividing the search space into smaller hyper-rectangles and evaluating the function at the center of each rectangle.

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

5. **Recursive Division**:
   - The selected rectangles are further divided, splitting into thirds along the axis directions. The order in which dimensions are split matters; lower function evaluations receive larger sub-rectangles. The process continues recursively, refining the search by focusing on the most promising regions.

6. **Convex Hull**:
   - The DIRECT method selects all intervals for which a Lipschitz constant exists such that their lower bounds have minimal value. These intervals form a piecewise-linear boundary along the lower-right of the $(r, f(c))$ space.

---

### Strengths of the DIRECT Algorithm
The strength of the DIRECT algorithm lies in its ability to systematically explore the entire search space while focusing on the most promising areas. This systematic coverage helps the algorithm escape local minima, making it particularly effective for objective functions with multiple local minima.
By not requiring the Lipschitz constant, the DIRECT algorithm is adaptable to various optimization problems, including those where the smoothness of the objective function is not well understood.
