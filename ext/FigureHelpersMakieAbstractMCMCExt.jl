module FigureHelpersMakieAbstractMCMCExt

# function __init__()
#     @info "FigureHelpers: loading FigureHelpersMakieAbstractMCMCExt"
# end

import FigureHelpers as CP 
using FigureHelpers
using Makie
#using Distributions
using AbstractMCMC
using StatsBase

const AChains = AbstractMCMC.AbstractChains

function CP.plot_chn(chns::AChains, args...; kwargs...)
    fig = Figure(; size = (1_000, 800))
    CP.plot_chn!(fig, chns, args...; kwargs...)
end

function CP.plot_chn!(fig::Figure, 
    chns::AChains; linkaxes=false, 
    param_label="Parameter estimate",
    params = names(chns, :parameters)
    )
    n_chains = size(chns, 3)
    n_samples = length(chns)
    for (i, param) in enumerate(params)
        ax = Axis(fig[i, 1]; ylabel = string(param))
        for chain in 1:n_chains
            values = chns[:, param, chain]
            lines!(ax, 1:n_samples, values; label = string(chain))
        end

        hideydecorations!(ax; label = false)
        if i < length(params)
            hidexdecorations!(ax; grid = false)
        else
            ax.xlabel = "Iteration"
        end
    end
    for (i, param) in enumerate(params)
        ax = Axis(fig[i, 2]; ylabel = string(param))
        for chain in 1:n_chains
            values = chns[:, param, chain]
            density!(ax, values; label = string(chain))
        end

        hideydecorations!(ax)
        if linkaxes 
          if i < length(params)
              hidexdecorations!(ax; grid = false)
          else
              ax.xlabel = param_label
          end
        else
            if i < length(params)
                hidexdecorations!(ax; grid = false, ticks=false, ticklabels=false)
            else
                ax.xlabel = string(param)
            end
        end
    end
    axes = [only(contents(fig[i, 2])) for i in 1:length(params)]
    if linkaxes 
      linkxaxes!(axes...)
    end
    axislegend(first(axes))
    return(fig)
end


# plot density from MCMCChains.value
function CP.density_params(chns, pars=names(chns, :parameters); 
    makie_config::MakieConfig=MakieConfig(), 
    fig = figure_conf(cm2inch.((8.3,8.3/1.618)); makie_config), 
    column = 1, xlims=nothing, 
    labels=nothing, colors = nothing, ylabels = nothing, normalize = false, 
    kwargs_axis = repeat([()],length(pars)), 
    prange = (0.025, 0.975), # do not extend x-scale to outliers
    kwargs...
    )
    n_chains = size(chns,3)
    n_samples = length(chns)
    labels_ch = isnothing(labels) ? string.(1:n_chains) : string.(labels)
    ylabels = isnothing(ylabels) ? string.(pars) : ylabels
    !isnothing(xlims) && (length(xlims) != length(pars)) && error(
        "Expected length(xlims)=$(length(xlims)) (each a Tuple or nothing) to be length(pars)=$(length(pars))")
    for (i, param) in enumerate(pars)
        ax = Axis(fig[i, column]; ylabel=ylabels[i], yaxisposition = :right, kwargs_axis[i]...)
        if isnothing(colors)
            pal = fig.scene.theme.palette 
            #pal = ax.palette
            colors = pal.color[]
        end
        for i_chain in 1:n_chains
            _values = chns[:, param, i_chain]
            if !isnothing(prange)
                qmin,qmax = StatsBase.quantile(_values, prange)
                _values = _values[qmin .<= _values .<= qmax]
            end
            col = colors[i_chain]
            if normalize
                k = KernelDensity.kde(_values)
                md = maximum(k.density)
                lines!(ax, k.x, k.density ./ md; label=labels_ch[i_chain], color = col, kwargs...)
            else
                density!(ax, _values; label=labels_ch[i_chain], color = (col, 0.3), strokecolor = col, strokewidth = 1, 
                #strokearound = true,
                kwargs...)
            end
        end
        xlim = CP.passnothing(getindex)(xlims, i)
        !isnothing(xlim) && xlims!(ax, xlim)
    #hideydecorations!(ax,  ticklabels=false, ticks=false, grid=false)
        hideydecorations!(ax, label=false, ticklabels=true)
        # if i < length(params)
        #     hidexdecorations!(ax; grid=false)
        # else
        #     ax.xlabel = "Parameter estimate"
        # end
    end
    # axes = [only(contents(fig[i, 2])) for i in 1:length(params)]
    # linkxaxes!(axes...)
    #axislegend(only(contents(fig[2, column])))
    fig    
end

"""
Histogram of several variables of a 3D array, i.e. MCMCChain.

The desnity plot may give wrong impressions, if probability mass is concentrated
at the borders, which can be inspected by plotting histograms instead.
"""
function CP.histogram_params(chns, pars=names(chns, :parameters); 
  makie_config::MakieConfig=MakieConfig(), 
  fig = figure_conf(cm2inch.((8.3,8.3/1.618)); makie_config), 
  column = 1, xlims=nothing, 
  labels=nothing, colors = nothing, ylabels = nothing, normalization = :pdf, 
  kwargs_axis = repeat([()],length(pars)), 
  ylimits = (0,1),
  kwargs...
  )
  n_chains = size(chns,3)
  n_samples = length(chns)
  labels_ch = isnothing(labels) ? string.(1:n_chains) : string.(labels)
  ylabels = isnothing(ylabels) ? string.(pars) : ylabels
  !isnothing(xlims) && (length(xlims) != length(pars)) && error(
      "Expected length(xlims)=$(length(xlims)) (each a Tuple or nothing) to be length(pars)=$(length(pars))")
  for (i, param) in enumerate(pars)
      ax = Axis(fig[i, column]; ylabel=ylabels[i], kwargs_axis[i]...)
      ylims!(ax, ylimits)
      if isnothing(colors)
            pal = fig.scene.theme.palette 
            #pal = ax.palette
            colors = pal.color[]
      end
      for i_chain in 1:n_chains
          _values = chns[:, param, i_chain]
          col = colors[i_chain]
          hist!(ax, _values; label=labels_ch[i_chain], color = (col, 0.3), strokecolor = col, strokewidth = 1, 
          normalization,
              #strokearound = true,
              kwargs...)
      end
      xlim = CP.passnothing(getindex)(xlims, i)
      !isnothing(xlim) && xlims!(ax, xlim)
  #hideydecorations!(ax,  ticklabels=false, ticks=false, grid=false)
      hideydecorations!(ax, label=false, ticklabels=true)
      # if i < length(params)
      #     hidexdecorations!(ax; grid=false)
      # else
      #     ax.xlabel = "Parameter estimate"
      # end
  end
  # axes = [only(contents(fig[i, 2])) for i in 1:length(params)]
  # linkxaxes!(axes...)
  #axislegend(only(contents(fig[2, column])))
  fig    
end



end

