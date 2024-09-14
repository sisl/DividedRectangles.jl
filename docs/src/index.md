# DividedRectangles.jl

[![CI](https://github.com/sisl/DividedRectangles.jl/actions/workflows/CI.yml/badge.svg)](https://github.com/sisl/DividedRectangles.jl/actions/workflows/CI.yml)
[![Documentation Status](https://img.shields.io/badge/docs-latest-blue.svg)](https://sisl.github.io/DividedRectangles.jl/)
[![codecov](https://codecov.io/gh/sisl/DividedRectangles.jl/graph/badge.svg?token=YALXFAP7UO)](https://codecov.io/gh/sisl/DividedRectangles.jl)
---

**DividedRectangles.jl** provides an implementation of the DIRECT (DIvided RECTangles) algorithm for global optimization. The DIRECT algorithm is particularly useful for optimizing functions where the Lipschitz constant is unknown. This package allows users to perform both univariate and multivariate optimization efficiently.

### Key Equation:
The algorithm is guided by the following fundamental equation:

```math
f(x) = \sum_{i=1}^{n} c_i x_i
```

where:
- ($x_i$) represents the variables.
- ($c_i$) represents the coefficients corresponding to each variable.

This equation forms the basis for dividing the search space into smaller rectangles, optimizing the function by evaluating it at specific points.

---

This documentation provides detailed usage examples, theoretical background, and advanced customization options to help you get the most out of `DividedRectangles.jl`.
