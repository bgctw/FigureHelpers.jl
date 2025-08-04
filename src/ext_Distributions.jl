"""
    density_dist(d::UnivariateDistribution; ...)
    density_dist!(ax, d::UnivariateDistribution; ...)

Plot density of univariate distribution, `d`.
The first variant produced a figure. The second plots into given Axis.

## Keyword arguments
- `normalize = false`: to scale y-axis to 1 for comparing densities with different spread
- `prange = (0.025, 0.975)`: truncate x-axis to focus on main mass of the density
"""
function density_dist end
function density_dist! end

function tmp end


