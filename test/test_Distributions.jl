using Test
using FigureHelpers
using Distributions
using CairoMakie

() -> begin
    #using WGLMakie
    WGLMakie.activate!()
end

@testset "plot_dist!" begin
    d = LogNormal()
    fig = density_dist(d; normalize=true, label="normalized")
    #save_with_config("tmp/test", fig; makie_config = paper_MakieConfig())
    ax = content(fig[1, 1])
    #ax = only(contents(fig[1, 1]))
    #methods(density_dist!)
    lab = density_dist!(ax, d)
    @test lab == "pdf(Distributions.LogNormal{Float64}(μ=0.0, σ=1.0))"
    #@test lab == "pdf(LogNormal{Float64}(μ=0.0, σ=1.0))"
    ax.xlabel = lab
    axislegend(ax, unique=true)
    fig
    #save_with_config("tmp/test", fig; makie_config = paper_MakieConfig())
end;

