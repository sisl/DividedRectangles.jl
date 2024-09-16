# Theory
 
The DIRECT (Divided Rectangles) algorithm is a global optimization method that does not require a known Lipschitz constant. This characteristic makes it particularly robust and versatile, applicable to a wide range of optimization problems. The algorithm operates by dividing the search space into smaller hyper-rectangles and evaluating the function at the center of each rectangle.

---
### Key Concepts of the DIRECT Algorithm

1. **Division of Search Space**:
   - The algorithm begins by treating the entire feasible region as a single hyper-rectangle.
   - This hyper-rectangle is then divided into smaller rectangles by splitting the dimensions.

2. **Function Evaluation**:
   - The function is evaluated at the center of each hyper-rectangle.
   - This evaluation helps in identifying the most promising regions for further exploration.

3. **Selection of Potentially Optimal Rectangles**:
   - After evaluation, the algorithm identifies potentially optimal rectangles. A rectangle is considered potentially optimal if it could contain the global minimum based on the evaluations performed so far.

4. **Recursive Division**:
   - The selected rectangles are further divided, and the process repeats.
   - The algorithm continues to refine the search by focusing more on regions that are likely to contain the global minimum.

---

## Mathematical Formulation
The algorithm relies on the following core mathematical principles:

**Evaluation Function**:  
The objective function $f(x)$ is evaluated at the center of each hyper-rectangle:

```math
f(x) = \sum_{i=1}^{n} c_i x_i
```

where $x_i$ are the variables, and $c_i$ are the corresponding coefficients.

- **Rectangle Selection Criterion**:
  A rectangle $R$ is considered potentially optimal if:
  
```math
  f(x_R) - L \cdot r_R \leq f(x) - L \cdot r_x \quad \text{for all } x \in R
```

  where:
  - $f(x_R)$ is the function value at the center of the rectangle.
  - $r_R$ is the radius of the rectangle.
  - $L$ is the Lipschitz constant.

**Recursive Division**:  
The hyper-rectangles are recursively divided along their longest dimension:

```math
x_R = \frac{a_i + b_i}{2}
```

where $a_i$ and $b_i$ are the bounds of the rectangle along the $i$-th dimension.

---

### Strengths of the DIRECT Algorithm

The strength of the DIRECT algorithm lies in its ability to systematically explore the entire search space while focusing on the most promising areas. This systematic coverage helps the algorithm escape local minima, making it particularly effective for objective functions with multiple local minima.

By not requiring the Lipschitz constant, the DIRECT algorithm is adaptable to various optimization problems, including those where the smoothness of the objective function is not well understood.
