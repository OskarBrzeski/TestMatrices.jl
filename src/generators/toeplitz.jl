import TestMatrices.Toeplitz

function rand_range_toeplitz(range::AbstractRange, m::Integer, n::Integer)
    tl = rand(range)
    row = rand(range, n - 1)
    col = rand(range, m - 1)
    return Toeplitz(tl, row, col)
end

function rand_symmetric_toeplitz(range::AbstractRange, m::Integer)
    tl = rand(range)
    row = rand(range, m - 1)
    return Toeplitz(tl, row, row)
end

function rand_sequence_toeplitz(sequence::AbstractVector, m::Integer, n::Integer)
    tl = rand(sequence)
    row = rand(sequence, n - 1)
    col = rand(sequence, m - 1)
    return Toeplitz(tl, row, col)
end
