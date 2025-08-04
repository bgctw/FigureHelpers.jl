"""
Conveniently adjust figure properties for publication and presentation.
"""
module FigureHelpers

include("util.jl")

include("makie_util.jl")
export cm_per_inch, cm2inch, golden_ratio, MakieConfig
export figure_conf, figure_conf_axis, save_with_config, ppt_MakieConfig, paper_MakieConfig
export hidexdecoration!, hideydecoration!, axis_contents

include("aog_util.jl")
export set_default_AoGTheme!, draw_with_legend!

export density_dist, density_dist!
include("ext_Distributions.jl")


export plot_chn, plot_chn!
export density_params, histogram_params
include("ext_AbstractMCMC.jl")

end # module
