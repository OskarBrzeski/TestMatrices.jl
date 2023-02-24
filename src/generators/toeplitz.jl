import TestMatrices.Toeplitz

function generate(::Type{Toeplitz}, range::AbstractRange, m::Integer, n::Integer)
    tl = rand(range)
    row = rand(range, n - 1)
    col = rand(range, m - 1)
    return Toeplitz(tl, row, col)
end

function generate(::Type{Toeplitz}, sequence::AbstractArray, m::Integer, n::Integer)
    tl = rand(sequence)
    row = rand(sequence, n - 1)
    col = rand(sequence, m - 1)
    return Toeplitz(tl, row, col)
end
