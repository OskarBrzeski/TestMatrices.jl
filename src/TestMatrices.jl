module TestMatrices

include("types/toeplitz.jl")
include("types/circulant.jl")

export Toeplitz
export Circulant

export issymmetric
export ishermitian

include("generators/toeplitz.jl")
include("generators/circulant.jl")

export rand_range_toeplitz
export rand_range_circulant

export rand_symmetric_toeplitz
export rand_symmetric_circulant

end
