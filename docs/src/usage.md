# Usage  
 
To use the `DividedRectangles` module, start your code with:

```julia
using DividedRectangles
```

The `optimize` function is the primary function of the `DividedRectangles` module. It implements the DIRECT algorithm to find the minimum of a given objective function within specified bounds.

To use the `optimize` function with a custom objective function::

```julia
using DividedRectangles

# Define the objective function
f(x) = x[1]^2 + x[2]^2 + 3 * sin(5 * x[1]) + 2 * cos(3 * x[2])  # Multivariate example

# Set the search bounds
a = [-2.0, -2.0]
b = [2.0, 2.0]

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
- The best design `x` found by DIRECT.


The package also provides `direct`, which is the same as `optimize` except it returns all hyperrectangular intervals:

```julia
using DividedRectangles

# Define the objective function
f(x) = x[1]^2 + x[2]^2 + 3 * sin(5 * x[1]) + 2 * cos(3 * x[2])  # Multivariate example

# Set the search bounds
a = [-2.0, -2.0]
b = [2.0, 2.0]

# Run DIRECT
intervals = direct(f, a, b, max_iterations=10, min_radius=1e-4)

```

**Arguments:**
- `f`: The objective function to be minimized.
- `a`: Vector of lower bounds for the search space.
- `b`: Vector of upper bounds for the search space.
- `max_iterations`: (Optional) The maximum number of iterations (default: 100).
- `min_radius`: (Optional) The minimum radius of hyper-rectangles (default: 1e-5).

**Returns:** 
- All hyperrectangular intervals maintained by DIRECT.

## Functions and Types

```@docs
DividedRectangles.basis
DividedRectangles.is_ccw
DividedRectangles.DirectRectangle
DividedRectangles.split_interval
DividedRectangles.get_split_intervals
DividedRectangles.direct
DividedRectangles.optimize
```
