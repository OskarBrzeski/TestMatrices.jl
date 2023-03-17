import TestMatrices.Hankel

function generate(::Type{Hankel}, range::AbstractRange, m::Integer, n::Integer)
    row = rand(range, n - 1)
    tr = rand(range)
    col = rand(range, m - 1)
    return Hankel(row, tr, col)
end

function generate(::Type{Hankel}, sequence::AbstractArray, m::Integer, n::Integer)
    row = rand(sequence, n - 1)
    tr = rand(sequence)
    col = rand(sequence, m - 1)
    return Hankel(row, tr, col)
end
