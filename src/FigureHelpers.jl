"""
Concepts in Julia that have not found its proper package.
"""
module FigureHelpers

include("util.jl")

include("makie_util.jl")
export cm_per_inch, cm2inch, golden_ratio, MakieConfig
export figure_conf, figure_conf_axis, save_with_config, ppt_MakieConfig, paper_MakieConfig
export hidexdecoration!, hideydecoration!, axis_contents, density_params, histogram_params

include("aog_util.jl")
export set_default_AoGTheme!, draw_with_legend!

  
end # module
