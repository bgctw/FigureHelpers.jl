using Test
using FigureHelpers
import FigureHelpers as CP
using CairoMakie
using MCMCChains
using AxisArrays: AxisArrays

() -> begin
    #using WGLMakie
    WGLMakie.activate!()
end

@testset "plot_chn" begin
    chn = Chains(rand(500, 2, 3), [:a, :b]);
    methods(plot_chn)
    fig = plot_chn(chn)
    #save_with_config("tmp/test", fig; makie_config = paper_MakieConfig())
    ax = fig.content[1,1]
    @test length(ax.scene.plots) >= 3
    #
    fig = plot_chn(chn; linkaxes=true)
    #save_with_config("tmp/test", fig; makie_config = paper_MakieConfig())
    ax = fig.content[1,1]
    @test length(ax.scene.plots) >= 3
end;

@testset "density_params" begin
    a = reshape(randn(40*3*2), (40,3,2));
    chn = AxisArrays.AxisArray(a; row=1:size(a,1), parameters=string.('a':'c'));
    methods(density_params)
    #plt = density_params(chn, AxisArrays.axes(chn,2));
    fig = density_params(chn, ["a","b"]);
    #save_with_config("tmp/test", fig; makie_config = paper_MakieConfig())
    #display(plt)
    @test fig isa CairoMakie.Figure

    chn1 = Chains(chn)
    fig = histogram_params(chn1)
    #save_with_config("tmp/test", fig; makie_config = paper_MakieConfig())
    @test fig isa CairoMakie.Figure
end;
