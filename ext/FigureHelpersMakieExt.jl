module FigureHelpersMakieExt

# function __init__()
#     @info "FigureHelpers: loading FigureHelpersMakieExt"
# end

using Makie
import FigureHelpers as CP
using FigureHelpers
using KernelDensity: KernelDensity
using StatsBase

function CP.figure_conf_axis(args...; makie_config::MakieConfig = MakieConfig(), kwargs...) 
    fig = figure_conf(args...; makie_config)
    fig, Axis(fig[1,1]; kwargs...)
end

function get_size_from_config(cfg)
    72 .* cfg.size_inches ./ cfg.pt_per_unit # size_pt
end
function get_fontsize_from_config(cfg)
    cfg.fontsize ./ cfg.pt_per_unit
end

function CP.figure_conf(; makie_config::MakieConfig = MakieConfig())
    size = get_size_from_config(makie_config)
    fontsize = get_fontsize_from_config(makie_config)
    Figure(;size, fontsize)
end
function CP.figure_conf(size_inches::NTuple{2}; makie_config::MakieConfig = MakieConfig())
    makie_config = MakieConfig(makie_config; size_inches)
    figure_conf(;makie_config)
end
function CP.figure_conf(width2height::Number, xfac=1.0; makie_config::MakieConfig = MakieConfig())
    wx = makie_config.size_inches[1] * xfac
    wy = wx/width2height
    makie_config_resized = MakieConfig(makie_config; size_inches = (wx, wy))
    figure_conf(;makie_config = makie_config_resized)
end


function CP.save_with_config(filename::AbstractString, fig::Union{Figure, Makie.FigureAxisPlot, Scene}; makie_config = MakieConfig(), args...)
    local cfg = makie_config
    pathname, ext = splitext(filename) 
    ext != "" && @warn "replacing extension $ext by $(cfg.filetype)"
    bname = basename(pathname) * "." *  cfg.filetype
    dir = joinpath(dirname(pathname), string(cfg.target))
    filename_cfg = joinpath(dir,bname)
    mkpath(dir)
    #save(filename_cfg, fig, args...)
    save(filename_cfg, fig, args...; pt_per_unit = makie_config.pt_per_unit)
    filename_cfg
end

CP.hidexdecoration!(ax; label = false, ticklabels = false, ticks = false, grid = false, minorgrid = false, minorticks = false, kwargs...) = hidexdecorations!(ax; label, ticklabels, ticks, grid, minorgrid, minorticks, kwargs...)

CP.hideydecoration!(ax; label = false, ticklabels = false, ticks = false, grid = false, minorgrid = false, minorticks = false, kwargs...) = hideydecorations!(ax; label, ticklabels, ticks, grid, minorgrid, minorticks, kwargs...)

CP.axis_contents(axis::Axis) = axis
CP.axis_contents(figpos::GridLayout) = axis_contents(first(contents(figpos)))
CP.axis_contents(figpos::GridPosition) = axis_contents(first(contents(figpos)))



end