# Algorithms  
**Important Note**: The content below is borrowed from Chapter 7, "Direct Methods," of the forthcoming second edition of "Algorithms for Optimization" by Mykel Kochenderfer and Tim Wheeler.

The DIRECT algorithm incrementally refines a rectangular partition of the design space, using a heuristic inspired by potential Lipschitz constants to guide the refinement. This partitioning allows for global optimization by balancing exploration and exploitation of the design space. 

---

## Normalization:

To simplify the mathematics and avoid oversensitivity to dimensions with larger domains, DIRECT first normalizes the search space to be the unit hypercube.

If we are minimizing $f(x)$ in the interval between lower and upper ranges $a$ and $b$ DIRECT will instead minimize:

```math
g(\mathbf{x}) = f(\mathbf{x} \odot (\mathbf{b} - \mathbf{a}) + \mathbf{a})
```

After finding the minimum $f(x)$ of $g$, the minimum of $f$ is:

```math
\mathbf{x}^* \odot (\mathbf{b} - \mathbf{a}) + \mathbf{a}
```

---

## Partitioning the Search Space:
DIRECT maintains a partition of this unit hypercube into hyperrectangular intervals. Each interval has:

- A center $c^{(i)}$
- An associated objective function value $f(c^{(i)})$
- A radius $r^{(i)}$, which is the distance from the center to a vertex.

DIRECT begins every iteration by identifying intervals to be split with additional function evaluations. It splits the intervals for which a Lipschitz constant $\ell$ exists such that that interval contains the Lipschitz lowerbound.

---

## Splitting Intervals

DIRECT splits the identified intervals along their longest dimensions, dividing each interval into thirds. These splits refine the resolution in areas of interest, increasing accuracy near the minimum while avoiding excessive evaluations in less promising regions. The heuristic ensures that intervals are split in a way that balances the need for exploring the global space and refining local areas of interest.


## Lipschitz Lower Bound

The Lipschitz lower bound for an interval is a circular cone extending downwards from its center $c^{(i)}$:

```math
f(\mathbf{x}) \geq f(\mathbf{c}^{(i)}) - \ell \|\mathbf{x} - \mathbf{c}^{(i)}\|_2
```

This lower bound helps guide the decision of which intervals to split. The intervals for which a Lipschitz constant $\ell$ exists such that the interval contains the Lipschitz lower bound are selected for further subdivision.

---

## Potentially Optimal Intervals:

DIRECT does not rely on a fixed Lipschitz constant. Instead, it selects potentially optimal intervals—those where a Lipschitz constant \( \ell \) could exist that makes the interval contain the global minimum. The process of identifying these intervals forms a **lower-right convex hull** in \( (r, f(c)) \)-space, which guides the algorithm to split the most promising intervals.

