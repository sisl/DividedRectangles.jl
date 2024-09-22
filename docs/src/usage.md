# Usage  
 
To use the `DividedRectangles` module, start your code with:

```julia
using DividedRectangles
```

---

## Core Functions

### `optimize`
The `optimize` function is the primary function of the `DividedRectangles` module. It implements the DIRECT algorithm to find the minimum of a given objective function within specified bounds.

To use the `optimize` function with a custom mathematical function:

```julia
using DividedRectangles

# Define the objective function
f(x) = dot([1.0, 2.0, 3.0], x)  # Example objective function with coefficients

# Set the search bounds
a = [0.0, 0.0, 0.0]
b = [1.0, 1.0, 1.0]

# Call the optimization function
result = optimize(f, a, b)

println("Best design found: ", result)

```

**Arguments:**
- `f`: The objective function to be minimized.
- `a`: Vector of lower bounds for the search space.
- `b`: Vector of upper bounds for the search space.
- `max_iterations`: (Optional) The maximum number of iterations (default: 100).
- `min_radius`: (Optional) The minimum radius of hyper-rectangles (default: 1e-5).

**Returns:** 
- The best design 𝑥 found by DIRECT.
---

### Example: Multivariate Optimization

The following example shows how to optimize a multivariate function using the DIRECT algorithm:

```julia
using DividedRectangles

# Define the objective function
f(x) = x[1]^2 + x[2]^2 + 3 * sin(5 * x[1]) + 2 * cos(3 * x[2])

# Set the search bounds
a = [-2.0, -2.0]
b = [2.0, 2.0]

# Optimize
result = DividedRectangles.optimize(f, a, b)

println("Best design found: ", result)
```
---

### Parameters
- `f`: This is the objective function to minimize. Should be an operation that accepts a vector of Float64 values.
- `a`: Vector representing the lower bounds of the search space.
- `b`: Vector representing the upper bounds of the search space.
- `max_iterations`:  Maximum number of iterations for the optimization (default: 100).
- `min_radius`: Minimum size of hyper-rectangles (`default: 1e-5`).
- 
---

## Advanced Usage
### Fine-Tuning Optimization:
The `optimize` function offers several parameters for fine-tuning the optimization process:

- `max_iterations`: Sets the maximum number of iterations. Increasing this value can improve accuracy but requires more computational time.
- `min_radius`: Specifies the minimum size of hyper-rectangles to control the granularity of the search.

```julia
result = DividedRectangles.optimize(f, a, b, max_iterations=500, min_radius=1e-6)
```
