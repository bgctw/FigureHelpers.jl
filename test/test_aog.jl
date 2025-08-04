using Test
using FigureHelpers
using CairoMakie
using AlgebraOfGraphics

@testset "pdf_figure with constants" begin
    makie_config = MakieConfig(filetype="png", target=:presentation)
    #makie_config = paper_MakieConfig()
    set_default_AoGTheme!(;makie_config)
    dft = (x=rand(100), y=rand(100), col=BitArray(rand() < 0.3 for x in 1:100))
    plt= AlgebraOfGraphics.data(dft) * mapping(:x, :y, color=:col => "Binary class")
    fig = pdf_figure(;makie_config)
    ffig = draw_with_legend!(fig, plt);
    @test fig.content[2,1] isa Legend
    #fname = save_with_config("tmp/test_legend", fig; makie_config)
end;

