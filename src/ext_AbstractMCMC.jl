"""
    plot_chn(fchns::AbstractMCMC.AbstractChains; ... )
    plot_chn!(fig::Figure, chns::AbstractMCMC.AbstractChains; ... )

Plot MCMCChain lines and density. The first variant produces a figure,
the second variant plots into a matrix-grid of axes into given figure.

## Keyword arguments
- `linkaxes=false`: link x-axis across density plots of several chains
- `param_label="Parameter estimate"`: x-axis label below lowest density plot
- `params = names(chns, :parameters)`: subset of parameters to plot
"""
function plot_chn end
function plot_chn! end

"""
    hdensity_params(chns, pars=names(chns, :parameters); 
        makie_config::MakieConfig=MakieConfig(), 
        fig = figure_conf(cm2inch.((8.3,8.3/1.618)); makie_config), 
        column = 1, xlims=nothing, 
        labels=nothing, colors = nothing, ylabels = nothing, normalize = false, 
        kwargs_axis = repeat([()],length(pars)), 
        prange = (0.025, 0.975), # do not extend x-scale to outliers
        kwargs...
    )
    histogram_params(chns, ...)        

Density/Histogram of several variables of a 3D array, i.e. `MCMCChain`.

## Arguments
- `column`: The axis-grid column into which to plot
- `xlims`: indexable of length(pars), providing `(lower,upper)` bounds tuple for x-limits
- `labels`, colors: names (default chain number) and colors (default palette) of the chains
- `ylabels`: column labels (default parameter names) 
- `normalize`: if true, scale all chain densities to maximum one for each row
- `kwargs_axis`: indexable of keyword arguments to axis for each parameter
- `prange`: bounds to the x-axis in percentiles
- `kwargs`: further keyword arguments to `lines!` (if normalize) or `density!`

Returns the created figure.

The density plot gives wrong impressions, if probability mass is concentrated
at the borders, therefore provide an histogram equivalent.
"""
function density_params end

function histogram_params end

