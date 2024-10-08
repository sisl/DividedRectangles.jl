# Algorithm 
 
The divided rectangles algorithm, or DIRECT (for DIvided RECTangles), incrementally refines a retangular partition of the design space. The refinement is driven by a heuristic that involves reasoning about potential Lipschitz constants. 

The strength of the DIRECT algorithm lies in its ability to systematically explore the entire search space while focusing on the most promising areas. This systematic coverage helps the algorithm escape local minima, making it particularly effective for objective functions with multiple local minima. 

Additionally, by not requiring the Lipschitz constant, the DIRECT algorithm is adaptable to various optimization problems, including those where the smoothness of the objective function is not well understood.

The figure below shows the DIRECT method after 16 iterations on the Branin function. The cells are much denser around the minima of the Branin function because the DIRECT method is designed to increase its resolution in promising regions.

![page_11](https://github.com/user-attachments/assets/b833bedd-41aa-40c5-a27f-26188a171797)

## Key Concepts of the DIRECT Algorithm

### **Search Space**:
   
The algorithm minimizes an objective function f(x) over a hyper-rectangular search space. The search space is then normalized to the unit hypercube to avoid oversensitivity to dimensions with larger domains. If given an objective function $f(x)$ in the interval between lower and upper domains $a$ and $b$, DIRECT will instead minimize:
  
  ```math
   g(\mathbf{x}) = f(\mathbf{x} \odot (\mathbf{b} - \mathbf{a}) + \mathbf{a})
```

After finding the minimum $x^*$ of $g$, the minimizer of $f$ is:

```math
\mathbf{x}^* \odot (\mathbf{b} - \mathbf{a}) + \mathbf{a}
```

### **Function Evaluation**:
DIRECT partitions its search space into hyperrectangular intervals. The objective function is evaluated at the center of each hyperrectangle. Each interval has a center $c^{(i)}$, an associated objective function value $f(c^{(i)})$, and a radius $r^{(i)}$. The radius is the distance from the center to a vertex.

### **Selection of Potentially Optimal Rectangles**:
In each iteration, the algorithm identifies potentially optimal intervals. An interval is considered potentially optimal if there exists a Lipschitz constant such that said interval could contain the global minimum based on the evaluations performed so far.

## Lipschitz Lower Bound:

The Lipschitz lower bound for an interval is a circular cone extending downward from its center $c^{(i)}$:

 ```math
  f(\mathbf{x}) \geq f(\mathbf{c}^{(i)}) - \ell \|\mathbf{x} - \mathbf{c}^{(i)}\|_2
``` 
This lower bound is constrained by the extents of the interval, and its lowest value is achieved at the vertices, which are all a distance $r^{(i)}$ from the center.
     
```math
f(c^{(i)}) - \ell r^{(i)}
```
The left plot below shows the intervals for the DIRECT method after 5 iterations on the Branin function. The right plot shows the interval objective function values versus their radii, which is useful for identifying intervals to split with further evaluations.

![page_12](https://github.com/user-attachments/assets/34da1f5e-c983-45cc-8b6c-531184d4b756)

The left plot below shows the Lipschitz lowerbounds constructed for the DIRECT intervals using the Lipschitz constant = 200, and highlights one interval. The right plot shows how the minimum value for the lowerbound within the highlighted interval is the same as the x-intercept for a line of slope passing through that interval’s $(r, f(c))$ point.

![page_13](https://github.com/user-attachments/assets/f023e6b0-ee8a-48fb-a8b6-c1b68d819377)

The left plot below continues to show the Lipschitz lowerbounds constructed for the DIRECT intervals using the Lipschitz constant = 200, but now highlights the interval containing the lowest value. The right plot shows how the lowest lowerbound for a given Lipschitz constant is the one with the lowest x-intercept in the right-hand plot.

![page_14](https://github.com/user-attachments/assets/7df39f70-2ef2-4eaa-a5de-54f93d21e653)

### **Recursive Division**:
The selected intervals are further divided, splitting into thirds along the axis directions. The order in which dimensions are split matters; lower function evaluations receive larger sub-rectangles. The process continues recursively, refining the search by focusing on the most promising regions.

### **Convex Hull**:
The DIRECT method selects all intervals for which a Lipschitz constant exists such that their lower bounds have minimal value. These intervals form a piecewise-linear boundary along the lower-right of the $(r, f(c))$ space.

The left plot shows the split intervals identified for this iteration of DIRECT on the Branin function. The right plot shows the lower-right convex hull formed by these split intervals in $(r, f(c))$ space.

![page_15](https://github.com/user-attachments/assets/5142788b-814e-4221-b50f-1746672278df)

## Splitting Intervals

When splitting a region without equal side lengths, only the longest dimensions are split. Splitting proceeds on these dimensions in the same manner as with a hypercube. The width in a given dimension depends on how many times that dimension has been split. Since DIRECT always splits axis directions by thirds, a dimension
that has been split $d$ times will have a width of $3^{−d}$. If we have $n$ dimensions and track how many times each dimension of a given interval has been split in a vector $d$, then the radius of that interval is

```math
r = \left\|\left[ \frac{1}{2 \cdot 3^{-d_1}}, \dots, \frac{1}{2 \cdot 3^{-d_n}} \right]\right\|_2
```
The figure below shows how interval splitting in for DIRECT requires choosing an ordering for the split dimensions:

  ![page_16](https://github.com/user-attachments/assets/962993d9-372a-4733-9d1f-0260cdacdff1)

DIRECT will only split the longest dimensions of intervals:

  ![page_17](https://github.com/user-attachments/assets/99caea66-02b5-4371-90e2-69305c035ddf)

Finally, DIRECT only splits intervals larger than a minimum radius. This minimum radius prevents inefficient function evaluations very close to existing points.
