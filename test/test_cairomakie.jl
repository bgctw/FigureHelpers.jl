using Test
using FigureHelpers
using CairoMakie
#using AlgebraOfGraphics

@testset "figure_conf with constants" begin
    makie_config = ppt_MakieConfig()
    makie_config = ppt_MakieConfig(filetype="pdf")
    #makie_config.size_inches ./ cm2inch(1)
    cfg2 = MakieConfig(makie_config, fontsize = 20)
    @test cfg2.fontsize == 20
    #
    @test all(isapprox.(cm2inch(6,7,9), (2.36, 2.75, 3.54); atol = 0.02))
    #
    # changing the size by first argument
    fig = figure_conf(cm2inch(8,8); makie_config = ppt_MakieConfig())
    @test size(fig.scene) == (302, 302) # regression test, but numbers must be equal
    #
    # changing with2height and xfac
    fig0 = figure_conf(; makie_config = ppt_MakieConfig()) 
    (x0,y0) = size(fig0.scene)
    fig = figure_conf(0.5, 1.2; makie_config = ppt_MakieConfig()) 
    @test size(fig.scene)[1] ≈ x0*1.2
    @test size(fig.scene)[2] ≈ x0*1.2/0.5
    #
    makie_config = MakieConfig(filetype="png", target=:presentation)
    # set_default_CMTheme!(;makie_config)  # aog-specific
    fig,ax = figure_conf_axis(golden_ratio;makie_config); 
    data = cumsum(randn(4, 101), dims = 2)
    series!(ax, data, labels=["label $i" for i in 1:4])
    ax.xlabel = "xlabel"; ax.ylabel = "ylabel"
    axislegend(ax)
    #display(fig)
    #save_with_config("tmp/test", fig; makie_config)
    #
    tmpdir = mktempdir()
    try
        fname = save_with_config(joinpath(tmpdir,"testfig"), fig; makie_config)
        @test fname == joinpath(tmpdir,"presentation","testfig.png")
    finally
        rm(tmpdir, recursive=true)
    end
    #
end;

i_test_larger_margins = () -> begin
    makie_config = ppt_MakieConfig(filetype="png")
    set_default_CMTheme!(;makie_config)
    fig,ax = figure_conf_axis(;makie_config); 
    data = cumsum(randn(4, 101), dims = 2)
    series!(ax, data, labels=["label $i" for i in 1:4])
    axislegend(ax)
    display(fig)
    passmissing(cumsum)
end


