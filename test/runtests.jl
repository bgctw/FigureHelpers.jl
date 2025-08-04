using Test, SafeTestsets
const GROUP = get(ENV, "GROUP", "All") # defined in in CI.yml
@show GROUP

@time begin
    if GROUP == "All" || GROUP == "CairoMakie"
        #join_path(test_path, ...) does not work, because test_path is unknown in new module
        #@safetestset "Tests" include("test/test_cairomakie.jl")
        @time @safetestset "test_cairomakie" include("test_cairomakie.jl")
    end

    # if GROUP == "All" || GROUP == "JET"
    #     #@safetestset "Tests" include("test/test_JET.jl")
    #     @time @safetestset "test_JET" include("test_JET.jl")
    #     #@safetestset "Tests" include("test/test_aqua.jl")
    #     @time @safetestset "test_Aqua" include("test_aqua.jl")
    # end
end

# @testset "non-required" begin
#     #TODO resolve SimpleTraits issue https://github.com/mauro3/SimpleTraits.jl/issues/83
#     include("test_isofeltype.jl")
#     include("test_util.jl")
#     include("test_data_management.jl")
# end



