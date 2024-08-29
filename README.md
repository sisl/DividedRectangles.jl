# DividedRectangles.jl

| **Linux** | **macOS** | **Windows** |
|-----------|-----------|-------------|
| [![CI](https://github.com/sisl/DividedRectangles.jl/actions/workflows/ci.yml/badge.svg?branch=add-tests-only&event=push&os=ubuntu-latest)](https://github.com/sisl/DividedRectangles.jl/actions) | [![CI](https://github.com/sisl/DividedRectangles.jl/actions/workflows/ci.yml/badge.svg?branch=add-tests-only&event=push&os=macos-latest)](https://github.com/sisl/DividedRectangles.jl/actions) | [![CI](https://github.com/sisl/DividedRectangles.jl/actions/workflows/ci.yml/badge.svg?branch=add-tests-only&event=push&os=windows-latest)](https://github.com/sisl/DividedRectangles.jl/actions) |


![Static Badge](https://img.shields.io/badge/doc-latest-blue)
![Julia version](https://img.shields.io/badge/julia%20version-%5E1.6-blue)
![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)


**DividedRectangles.jl** provides an implementation of the DIRECT (DIvided RECTangles) algorithm for global optimization. The DIRECT algorithm is particularly useful for optimizing functions where the Lipschitz constant is unknown. This package allows users to perform both univariate and multivariate optimization efficiently.

## Installation

To install the package, start Julia and run the following command:

```julia
Pkg.add("DividedRectangles")
```

## Usage

To use the `DividedRectangles` module, start your code with:

```julia
using DividedRectangles
```

### Example: Univariate Optimization

The following example demonstrates how to use the DIRECT algorithm to find the minimum of a univariate function:

```julia
using DividedRectangles

# Define the objective function
f(x) = sin(5 * x) + cos(2 * x)

# Set the search bounds
a = [-1.0]
b = [2.0]

# Optimize
result = DividedRectangles.optimize(f, a, b)

println("Optimal value found at: ", result)
```

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

println("Optimal value found at: ", result)
```

### Parameters
- `f`: This is the objective function to minimize. Should be an operation that accepts a vector of Float64 values.
- `a`: A vector with the lower bounds to be used in the search space.
- `b`: An upper-bound vector for the search space.
- `max_iterations`:  Maximum number of iterations to run the optimization. The default is 100.
- `min_radius`: The minimum allowable size of a hyper-rectangle (default: '1e-5').

## Theory
The DIRECT algorithm does not require a known Lipschitz constant; therefore, it is quite robust for a wide range of optimization problems. It divides the search space into smaller hyper-rectangles, recursively, with a function evaluation at the center of every rectangle, and focuses further exploration in the most promising regions.

The power of this algorithm stems from the fact that it works against any problem whose objective function contains a number of local minima, since it escapes local minima by systematically covering the entire search space.

## Core Functions

### `optimize`
The `optimize` function is the primary function of the `DividedRectangles` module. It implements the DIRECT algorithm to find the minimum of a given objective function within specified bounds.

**Arguments:**
- `f`: The objective function to be minimized.
- `a`: Vector of lower bounds for the search space.
- `b`: Vector of upper bounds for the search space.
- `max_iterations`: (Optional) The maximum number of iterations (default: 100).
- `min_radius`: (Optional) The minimum radius of hyper-rectangles (default: 1e-5).

**Returns:** 
- A vector representing the coordinates of the optimal point found.

## Advanced Usage
### Fine-Tuning Optimization:
The `optimize` function offers several parameters for fine-tuning the optimization process:

- `max_iterations`: Sets the maximum number of iterations to perform. Increasing this value may improve the accuracy of the result but will require more computational time.
- `min_radius`: Specifies the minimum allowable size of the hyper-rectangles. This can be adjusted to control the granularity of the search.
Example with custom parameters:

```julia
result = DividedRectangles.optimize(f, a, b, max_iterations=500, min_radius=1e-6)
```
## Parallelization

For large-scale optimization problems, the package can leverage Julia's parallel computing capabilities. You can distribute the evaluation of function centers across multiple cores or nodes, significantly speeding up the optimization process.

```julia
using Distributed
addprocs(4)  # Add 4 worker processes

@everywhere using DividedRectangles

result = DividedRectangles.optimize(f, a, b)
```
## Visualization

To better understand the optimization process, here are visualizations that represent different stages and aspects of the DIRECT algorithm's progress:

*Figure 7.12: Lipschitz Lower Bound vs. Divided Rectangles Lower Bound:*  
![Image 14](https://github.com/user-attachments/assets/60879517-d179-48c5-8db1-a0536396948f)


The left contour plot shows the Lipschitz lower bound using five function evaluations. The right contour plot shows the approximation made by DIRECT, which divides the region into hyper-rectangles—one centered about each design point. Making this assumption allows for the rapid calculation of the minimum of the lower bound.

---

*Figure 7.13: Lipschitz Lower Bound for Different Lipschitz Constants:*  
![Image 12](https://github.com/user-attachments/assets/f17d34e5-b180-4a5a-bb1e-0ba1d42890e8)


The Lipschitz lower bound for different Lipschitz constants (`l`). The estimated minimum changes locally as the Lipschitz constant is varied, and the region in which the minimum lies can also vary.

---

Figure 7.14: DIRECT Lower Bound for Different Lipschitz Constants:*
![Image 13](https://github.com/user-attachments/assets/f4785cb8-84b1-4b8e-8d36-f066739176eb)

The DIRECT lower bound for different Lipschitz constants (`l`). The lower bound is not continuous, and while the minimum does not change locally, it can change regionally as the Lipschitz constant changes.

---

*Figure 7.15: Center-point Sampling with the DIRECT Scheme:*  
![Image 21](https://github.com/user-attachments/assets/42b2c429-9a27-4eb7-833a-e63707157f77)

Center-point sampling using the DIRECT scheme, which divides intervals into thirds.

---

*Figure 7.15: Center-point Sampling with the DIRECT Scheme:*  
![Image 21](https://github.com/user-attachments/assets/42b2c429-9a27-4eb7-833a-e63707157f77)

Center-point sampling using the DIRECT scheme, which divides intervals into thirds.

---

*Figure 7.18: Potentially-Optimal Hyper-Rectangle Identification:*  
![Image 18](https://github.com/user-attachments/assets/882aa8ea-538c-4830-bdac-6579b8d38068)

Potentially-optimal hyper-rectangle identification for a particular Lipschitz constant (`l`). Black dots represent DIRECT hyper-rectangles and their location in `(f(c), r)` space. The potentially optimal hyper-rectangles form a piecewise-linear boundary along the lower-right of this space.

---

*Figure 7.19: Piecewise Boundary of Potentially Optimal Intervals:*  
![Image 20](https://github.com/user-attachments/assets/0d7184e2-a2b0-49cd-abdb-c9797365d569)

The potentially optimal intervals for the DIRECT method form a piecewise boundary that encloses all intervals along the lower-right.

---

*Figure 7.20: DIRECT Method After 16 Iterations:*  
![Image 17](https://github.com/user-attachments/assets/4cc10f72-5f7e-4b71-9118-01eafa095be9)

The DIRECT method after 16 iterations on the Branin function. Each cell is bordered by white lines. The cells are much denser around the minima of the Branin function, as the DIRECT method procedurally increases its resolution in those regions.



## Credits

Contributors to this package include Anshrin Srivastava, Mykel Kochenderfer, and Tim Wheeler.

---
