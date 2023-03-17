module TestMatrices

include("types/toeplitz.jl")
include("types/circulant.jl")
include("types/hankel.jl")
include("types/hilbert.jl")

export Toeplitz
export Circulant
export Hankel
export Hilbert

export issymmetric
export ishermitian

include("generators/toeplitz.jl")
include("generators/circulant.jl")

export generate

end
