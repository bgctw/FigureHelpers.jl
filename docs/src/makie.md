# Makie Helpers

## Unit conversions
Many graphical properties are given in pixel or inches.
Working with figures for international journals, however, usually requires
thinking and specification in metric units. 
The following function help to convert.

```@docs
cm2inch
```

Figures often look well, if the ratio between length and hight corresponds
to the [Golden ratio](https://en.wikipedia.org/wiki/Golden_ratio). 
So we provide it here.

```@docs
golden_ratio
```

## Makie Layout switching and Figure generation

Generating the same plot for paper and for a presentation, requires adjusting
properties such as figure sizes, fontsizes, and graphics format.
The following class helps to collect them and provide them to functions below
```@docs
MakieConfig
```

### creating figures with adjusted sizes and font-sizes

```@docs
figure_conf
figure_conf_axis
```
### saving figures to correct format and dpi-resolution

```@docs
save_with_config
```

## Shortcuts
```@docs
hidexdecoration!
axis_contents
```

## Plots of univariate Distributions

```@setup doc
using FigureHelpers
using CairoMakie
```
```@example doc
using Distributions
d = LogNormal()
fig = density_dist(d; normalize=true, label="normalized");
density_dist!(content(fig[1, 1]), d) # unnormalized into the same figure
fig
```

```@docs
density_dist
```

## Plots of MCMCChains
### Overview: combined trace-plot with density plot.
For `linkaxes=true`, all the density plots are on the same x-scale.

```@setup doc
using FigureHelpers
using CairoMakie
```
```@example doc
using MCMCChains
chn = Chains(rand(500, 2, 3), [:a, :b]);
fig = plot_chn(chn; linkaxes=true)
fig
```

```@docs
plot_chn
```

### Tailored density plot
Supports more keyword arguments to adjust color and labels.

```@example doc
using MCMCChains
chn = Chains(rand(500, 2, 3), [:a, :b]);
fig = density_params(chn, ["a","b"], labels=["bla","foo","bar"]);
fig[:, 2] = Legend(fig, content(fig[1,1]), "Chain", framevisible = false)
fig
```

```@docs
density_params
```

