# DividedRectangles.jl   

[![CI](https://github.com/sisl/DividedRectangles.jl/actions/workflows/CI.yml/badge.svg)](https://github.com/sisl/DividedRectangles.jl/actions/workflows/CI.yml)
[![Documentation Status](https://img.shields.io/badge/docs-latest-blue.svg)](https://sisl.github.io/DividedRectangles.jl/)
[![codecov](https://codecov.io/gh/sisl/DividedRectangles.jl/graph/badge.svg?token=YALXFAP7UO)](https://codecov.io/gh/sisl/DividedRectangles.jl)
---

**Important Note**: The content in this package is borrowed from Chapter 7, "Direct Methods," of the forthcoming second edition of "Algorithms for Optimization" by Mykel Kochenderfer and Tim Wheeler.

**DividedRectangles.jl** provides an implementation of the DIRECT (DIvided RECTangles) [algorithm for global optimization](https://scholar.google.com/scholar?hl=en&as_sdt=0%2C5&q=Lipschitzian+optimization+without+the+Lipschitz+constant&btnG=). The DIRECT algorithm is particularly useful for optimizing functions where the Lipschitz constant is unknown. This package allows users to perform both univariate and multivariate optimization efficiently.

---

Example Objective Function:
As an example of an objective function, consider:

```julia
f(x) = dot(coeffs, x)
```
where:
- `x`: represents the variables.
- `coeffs`: represents the coefficients corresponding to each variable.

This is just one possible objective function that could be optimized using the DIRECT algorithm. The algorithm works by dividing the search space into smaller rectangles and evaluating the function at specific points within these rectangles to find the optimal solution.

---

This documentation provides detailed usage examples, theoretical background, and advanced customization options to help you get the most out of `DividedRectangles.jl`.
