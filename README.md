# DividedRectangles.jl   

[![CI](https://github.com/sisl/DividedRectangles.jl/actions/workflows/CI.yml/badge.svg)](https://github.com/sisl/DividedRectangles.jl/actions/workflows/CI.yml)
[![Documentation Status](https://img.shields.io/badge/docs-latest-blue.svg)](https://sisl.github.io/DividedRectangles.jl/)
[![codecov](https://codecov.io/gh/sisl/DividedRectangles.jl/graph/badge.svg?token=YALXFAP7UO)](https://codecov.io/gh/sisl/DividedRectangles.jl)
---

**Important Note**: The content in this package is borrowed from Chapter 7, "Direct Methods," of the forthcoming second edition of "Algorithms for Optimization" by Mykel Kochenderfer and Tim Wheeler.

**DividedRectangles.jl** provides an implementation of the DIRECT (DIvided RECTangles) [algorithm for global optimization](https://scholar.google.com/scholar?hl=en&as_sdt=0%2C5&q=Lipschitzian+optimization+without+the+Lipschitz+constant&btnG=). The DIRECT algorithm is particularly useful for optimizing functions where the Lipschitz constant is unknown. This package allows users to perform both univariate and multivariate optimization efficiently.

- The figure below shows the DIRECT method after 16 iterations on the Branin function. The cells are much denser around the minima of the Branin function because the DIRECT method is designed to increase its resolution in promising regions.

![page_11](https://github.com/user-attachments/assets/b833bedd-41aa-40c5-a27f-26188a171797)


This documentation provides detailed usage examples, theoretical background, and advanced customization options to help you get the most out of `DividedRectangles.jl`.

## Installation

To install the package, start Julia and run the following command:

```julia
using Pkg
Pkg.add(url="https://github.com/sisl/DividedRectangles.jl")

```
# Usage  
 
To use the `DividedRectangles` module, start your code with:

```julia
using DividedRectangles
```

## Core Functions

### `optimize`
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
- The best design 𝑥 found by DIRECT.

## Credits

Contributors to this package include Anshrin Srivastava, Mykel Kochenderfer, Dylan Asmar, and Tim Wheeler.
