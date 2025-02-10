# Usage  
 
To use the `DividedRectangles` module, start your code with:

```julia
using DividedRectangles
```

The [`optimize`](@ref) function is the primary function of the `DividedRectangles` module. It implements the DIRECT algorithm to find the minimum of a given objective function within specified bounds. 

The package also provides [`direct`](@ref), which is the same as [`optimize`](@ref) except it returns all hyperrectangular intervals.

For details on function arguments and return values, see the documentation for [`optimize`](@ref) and [`direct`](@ref).

## Example: Optimizing a Multivariate Function

```@example
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
## Example: Returning All Hyperrectangular Intervals
```@example
using DividedRectangles

# Define the objective function
f(x) = x[1]^2 + x[2]^2 + 3 * sin(5 * x[1]) + 2 * cos(3 * x[2])  # Multivariate example

# Set the search bounds
a = [-2.0, -2.0]
b = [2.0, 2.0]

# Run DIRECT
intervals = direct(f, a, b, max_iterations=10, min_radius=1e-4)

```

## Functions and Types

```@docs
DividedRectangles.direct
DividedRectangles.optimize
DividedRectangles.basis
DividedRectangles.is_ccw
DividedRectangles.DirectRectangle
DividedRectangles.split_interval
DividedRectangles.get_split_intervals
```
