module TestMatrices

include("types/chow.jl")
include("types/circulant.jl")
include("types/clement.jl")
include("types/hankel.jl")
include("types/hilbert.jl")
include("types/permutation.jl")
include("types/toeplitz.jl")

export Chow
export Circulant
export Clement
export Hankel
export Hilbert
export Permutation
export Toeplitz

export issymmetric
export ishermitian

include("generators/toeplitz.jl")
include("generators/circulant.jl")
include("generators/hankel.jl")
include("generators/hilbert.jl")

export generate

end
