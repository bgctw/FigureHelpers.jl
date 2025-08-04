# Makie Helpers

## Unit conversions
Many graphical properties are given in pixel or inches.
Working with figures for international journals, however, usually requires
thinking and specification in metric units. 
The following function help to convert.

```@docs
cm2inch
```

Figures often look well, if the ratio between length and hight corresponds
to the [Golden ratio](https://en.wikipedia.org/wiki/Golden_ratio). 
So we provide it here.

```@docs
golden_ratio
```

## Makie Layout switching and Figure generation

Generating the same plot for paper and for a presentation, requires adjusting
properties such as figure sizes, fontsizes, and graphics format.
The following class helps to collect them and provide them to functions below
```@docs
MakieConfig
```

### creating figures with adjusted sizes and font-sizes

```@docs
figure_conf
figure_conf_axis
```
### saving figures to correct format and dpi-resolution

```@docs
save_with_config
```

## Shortcuts
```@docs
hidexdecoration!
axis_contents
```

## Tailored plots
```@docs
density_params
```
