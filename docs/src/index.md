# DividedRectangles.jl   

[![CI](https://github.com/sisl/DividedRectangles.jl/actions/workflows/CI.yml/badge.svg)](https://github.com/sisl/DividedRectangles.jl/actions/workflows/CI.yml)
[![Documentation Status](https://img.shields.io/badge/docs-latest-blue.svg)](https://sisl.github.io/DividedRectangles.jl/)
[![codecov](https://codecov.io/gh/sisl/DividedRectangles.jl/graph/badge.svg?token=YALXFAP7UO)](https://codecov.io/gh/sisl/DividedRectangles.jl)


**Important Note**: The content in this package is borrowed from Chapter 7, "Direct Methods," of the forthcoming second edition of "Algorithms for Optimization" by Mykel Kochenderfer and Tim Wheeler.

**DividedRectangles.jl** provides an implementation of the DIRECT (DIvided RECTangles) [algorithm for global optimization](https://scholar.google.com/scholar?hl=en&as_sdt=0%2C5&q=Lipschitzian+optimization+without+the+Lipschitz+constant&btnG=). The DIRECT algorithm is particularly useful for optimizing functions where the Lipschitz constant is unknown. This package allows users to perform both univariate and multivariate optimization efficiently.

The figure below shows the DIRECT method after 16 iterations on the Branin function. The cells are much denser around the minima of the Branin function because the DIRECT method is designed to increase its resolution in promising regions.
  
![page_11](https://github.com/user-attachments/assets/b833bedd-41aa-40c5-a27f-26188a171797)

This documentation provides detailed usage examples, a theoretical background, and advanced customization options to help you get the most out of `DividedRectangles.jl`.
