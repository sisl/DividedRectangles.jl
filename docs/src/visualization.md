## Visualization

To better understand the optimization process, here are visualizations that represent different stages and aspects of the DIRECT algorithm's progress:

![Image 14](assets/page_14.svg)


The left contour plot shows the Lipschitz lower bound using five function evaluations. The right contour plot shows the approximation made by DIRECT, which divides the region into hyper-rectangles—one centered about each design point. Making this assumption allows for the rapid calculation of the minimum of the lower bound.

---


![Image 12](assets/page_12.svg)


The Lipschitz lower bound for different Lipschitz constants (`l`). The estimated minimum changes locally as the Lipschitz constant is varied, and the region in which the minimum lies can also vary.

---


![Image 13](assets/page_13.svg)

The DIRECT lower bound for different Lipschitz constants (`l`). The lower bound is not continuous, and while the minimum does not change locally, it can change regionally as the Lipschitz constant changes.

---


![Image 21](assets/page_21.svg)

Center-point sampling using the DIRECT scheme, which divides intervals into thirds.

---


![Image 21](assets/page_21.svg)

Center-point sampling using the DIRECT scheme, which divides intervals into thirds.

---


![Image 18](assets/page_18.svg)

Potentially-optimal hyper-rectangle identification for a particular Lipschitz constant (`l`). Black dots represent DIRECT hyper-rectangles and their location in `(f(c), r)` space. The potentially optimal hyper-rectangles form a piecewise-linear boundary along the lower-right of this space.

---


![Image 20](assets/page_20.svg)

The potentially optimal intervals for the DIRECT method form a piecewise boundary that encloses all intervals along the lower-right.

---


![Image 17](assets/page_17.svg)

The DIRECT method after 16 iterations on the Branin function. Each cell is bordered by white lines. The cells are much denser around the minima of the Branin function, as the DIRECT method procedurally increases its resolution in those regions.