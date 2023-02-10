module TestMatrices

include("types/toeplitz.jl")
include("types/circulant.jl")

export Toeplitz
export Circulant

export issymmetric
export ishermitian

include("generators/toeplitz.jl")

end
