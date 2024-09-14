# DividedRectangles.jl

[![CI](https://github.com/sisl/DividedRectangles.jl/actions/workflows/CI.yml/badge.svg)](https://github.com/sisl/DividedRectangles.jl/actions/workflows/CI.yml)
[![Documentation Status](https://img.shields.io/badge/docs-latest-blue.svg)](https://sisl.github.io/DividedRectangles.jl/)
[![codecov](https://codecov.io/gh/sisl/DividedRectangles.jl/graph/badge.svg?token=YALXFAP7UO)](https://codecov.io/gh/sisl/DividedRectangles.jl)
---

**DividedRectangles.jl** provides an implementation of the DIRECT (DIvided RECTangles) algorithm for global optimization. The DIRECT algorithm is particularly useful for optimizing functions where the Lipschitz constant is unknown. This package allows users to perform both univariate and multivariate optimization efficiently.

### Key Equation:
The algorithm is guided by the following fundamental equation:

$$
f(x) = \sum_{i=1}^{n} c_i x_i
$$

where:
- \( x_i \) represents the variables.
- \( c_i \) represents the coefficients corresponding to each variable.

This equation forms the basis for dividing the search space into smaller rectangles, optimizing the function by evaluating it at specific points.

---

This documentation provides detailed usage examples, theoretical background, and advanced customization options to help you get the most out of `DividedRectangles.jl`.

## Installation

To install the package, start Julia and run the following command:

```julia
using Pkg
Pkg.add(url="https://github.com/sisl/DividedRectangles.jl")

```
## Usage

To use the `DividedRectangles` module, start your code with:

```julia
using DividedRectangles
```
## Core Functions

### `optimize`
The `optimize` function is the primary function of the `DividedRectangles` module. It implements the DIRECT algorithm to find the minimum of a given objective function within specified bounds.

To use the `optimize` function with a custom mathematical function:

```julia
using DividedRectangles

# Define the objective function
f(x) = sum(c * xi for (c, xi) in zip(coeffs, x))

# Call the optimization function
result = optimize(f, a, b)

println("Optimal value found at: ", result)
```

**Arguments:**
- `f`: The objective function to be minimized.
- `a`: Vector of lower bounds for the search space.
- `b`: Vector of upper bounds for the search space.
- `max_iterations`: (Optional) The maximum number of iterations (default: 100).
- `min_radius`: (Optional) The minimum radius of hyper-rectangles (default: 1e-5).

**Returns:** 
- A vector representing the coordinates of the optimal point found.
  
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

The DIRECT (DIvided RECTangles) algorithm is a global optimization method that does not require a known Lipschitz constant. This characteristic makes it particularly robust and versatile, applicable to a wide range of optimization problems. The algorithm operates by dividing the search space into smaller hyper-rectangles and evaluating the function at the center of each rectangle.

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

## Mathematical Formulation
The algorithm relies on the following core mathematical principles:

**Evaluation Function**:  
The objective function \( f(x) \) is evaluated at the center of each hyper-rectangle:

$$
f(x) = \sum_{i=1}^{n} c_i x_i
$$

where \( x_i \) are the variables, and \( c_i \) are the corresponding coefficients.

**Rectangle Selection Criterion**:  
A rectangle \( R \) is considered potentially optimal if:

$$
f(x_R) - L \cdot r_R \leq f(x) - L \cdot r_x \quad \text{for all } x \in R
$$

where:

- `f(x_R)` is the function value at the center of the rectangle.
- `r_R` is the radius of the rectangle.
- `L` is the Lipschitz constant.

**Recursive Division**:  
The hyper-rectangles are recursively divided along their longest dimension:

$$
x_R = \frac{a_i + b_i}{2}
$$

where \( a_i \) and \( b_i \) are the bounds of the rectangle along the \( i \)-th dimension.

---

### Strengths of the DIRECT Algorithm

The strength of the DIRECT algorithm lies in its ability to systematically explore the entire search space while focusing on the most promising areas. This systematic coverage helps the algorithm escape local minima, making it particularly effective for objective functions with multiple local minima.

By not requiring the Lipschitz constant, the DIRECT algorithm is adaptable to various optimization problems, including those where the smoothness of the objective function is not well understood.

## Advanced Usage
### Fine-Tuning Optimization:
The `optimize` function offers several parameters for fine-tuning the optimization process:

- `max_iterations`: Sets the maximum number of iterations to perform. Increasing this value may improve the accuracy of the result but will require more computational time.
- `min_radius`: Specifies the minimum allowable size of the hyper-rectangles. This can be adjusted to control the granularity of the search.
Example with custom parameters:

```julia
result = DividedRectangles.optimize(f, a, b, max_iterations=500, min_radius=1e-6)
```
## Credits

Contributors to this package include Anshrin Srivastava, Mykel Kochenderfer, Dylan Asmar, and Tim Wheeler.
