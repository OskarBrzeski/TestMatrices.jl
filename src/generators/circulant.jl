import TestMatrices.Circulant

rand_range_circulant(range::AbstractRange, m::Integer) = Circulant(rand(range, m))

function rand_symmetric_circulant(range::AbstractRange, m::Integer)
    tl = rand(range)
    row = rand(range, m÷2)
    if m % 2 == 0
        fullrow = [tl, row..., reverse(row[1:end-1])...]
    else
        fullrow = [tl, row..., reverse(row)...]
    end
    return Circulant(fullrow)
end
