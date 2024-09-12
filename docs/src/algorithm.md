## Algorithm

To better understand the optimization process, here are some visualizations that represent different stages and aspects of the DIRECT algorithm's progress:

![Image 14](assets/page_14.svg)


The Lipschitz lower bound for different Lipschitz constants. Not only does the estimated minimum change locally as the Lipschitz constant is varied, the region in which the minimum lies can vary as well.


---

![Image 13](assets/page_13.svg)

The DIRECT lower bound for different Lipschitz constants `. The lower bound is not continuous. The minimum does not change locally but can change regionally as the Lipschitz constant changes

---

![Image 12](assets/page_12.svg)

The left contour plot shows such a lower bound using five function evaluations. The right contour plot shows the approximation made by DIRECT, which divides the region into hyper-rectangles—one centered
about each design point. Making this assumption allows for the rapid calculation of the minimum of the lower bound.

---


![Image 21](assets/page_21.svg)

The potentially optimal intervals for the DIRECT method form a piecewise boundary that encloses all intervals along the lower-right. Each dot corresponds to a hyper-rectangle.


---

![Image 20](assets/page_20.svg)

Potentially-optimal hyper-rectangle identification for a particular Lipschitz constant. Black dots represent DIRECT hyper-rectangles and their location in (f(c),r) space. A black line of slope ` is drawn through the dot belonging to the best interval. The dots for all other hyper-rectangles
must lie on or above this line.

---

![Image 18](assets/page_18.svg)

Interval splitting in multiple dimensions (using DIRECT) requires choosing an ordering for the split dimensions.

---


![Image 17](assets/page_17.svg)

Consider the function $f(x) = sin(x) + sin(2x) + sin(4x) + sin(8x)$ on the interval [−2, 2] with a global minimizer near −0.272. Optimization is difficult because of multiple local minima. The figure above shows the progression of the univariate DIRECT method on this objective function, with intervals chosen for splitting rendered in blue.

---

**Important Note**: The content above is borrowed from Chapter 7, ***"Direct Methods,"*** of the forthcoming second edition of ***"Algorithms for Optimization"*** by Mykel Kochenderfer and Tim Wheeler.
