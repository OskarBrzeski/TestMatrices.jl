import TestMatrices.Circulant

generate(::Type{Circulant}, range::AbstractRange, m::Integer) = Circulant(rand(range, m))
generate(::Type{Circulant}, sequence::AbstractArray, m::Integer) = Circulant(rand(sequence, m))
