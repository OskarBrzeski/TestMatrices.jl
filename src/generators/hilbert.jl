import TestMatrices.Hilbert

generate(::Type{Hilbert}, range::AbstractRange) = Hilbert(rand(range))
generate(::Type{Hilbert}, sequence::AbstractArray{Integer}) = Hilbert(rand(sequence))
