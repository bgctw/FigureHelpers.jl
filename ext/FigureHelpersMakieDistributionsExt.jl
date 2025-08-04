module FigureHelpersMakieDistributionsExt

# function __init__()
#     @info "FigureHelpers: loading FigureHelpersMakieDistributionsExt"
# end

import FigureHelpers as CP 
using FigureHelpers
using Makie
using Distributions

function CP.density_dist(d::UnivariateDistribution; kwargs...)
    fig = Figure()
    ax = Axis(fig[1,1])
    CP.density_dist!(ax,d; kwargs...)
    return(fig)
end

function CP.density_dist!(ax, d::UnivariateDistribution;
        normalize = false,
        prange = (0.025, 0.975), # do not extend x-scale to outliers
        label = begin
            b = IOBuffer()
            show(b,d)
            "pdf("*String(take!(b))*")"
        end,
        xlab=missing, ylab=missing,
        kwargs...)
    qmin, qmax = quantile.(Ref(d), prange)
    q = range(qmin, qmax, length = 100)
    d = pdf.(Ref(d), q)
    if normalize
        d = d ./ maximum(d)
    end
    lines!(ax, q, d; label, kwargs...)
    #hideydecorations!(ax, label = false, ticklabels = true)
    return(label)
end

end

