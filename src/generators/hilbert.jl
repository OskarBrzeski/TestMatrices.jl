import TestMatrices.Hilbert

generate(::Type{Hilbert}, range::AbstractRange, m::Integer) = Hilbert(rand(range))
generate(::Type{Hilbert}, sequence::AbstractArray, m::Integer) = Hilbert(rand(sequence))
