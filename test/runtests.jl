using SafeTestsets

@safetestset "toeplitz.jl tests" begin include("type_tests/toeplitz_tests.jl") end
@safetestset "circulant.jl tests" begin include("type_tests/circulant_tests.jl") end
@safetestset "hilbert.jl tests" begin include("type_tests/hilbert_tests.jl") end
