# DividedRectangles.jl

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
  
## Credits

Contributors to this package include Anshrin Srivastava, Mykel Kochenderfer, and Tim Wheeler.

---
