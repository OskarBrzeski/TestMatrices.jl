import Base.axes
import Base.getindex
import Base.setindex!
import Base.length
import Base.size

struct Chow <: AbstractMatrix{Integer}
    size::Integer
    α::Integer
    δ::Integer
    function Chow(size, α, δ)
        new(size, α, δ)
    end
end

# AbstractArray interface methods

size(A::Chow) = (A.size, A.size)
function size(A::Chow, d::Integer)
    if d < 0
        throw("dimension must be ≥ 1, got $d")
    elseif d ≤ 2
        return A.size
    else
        return 1
    end
end

@inline function getindex(A::Chow, i::Integer, j::Integer)
    @boundscheck checkbounds(A, i, j)
    power = i - j + 1
    if power < 0
        result = 0
    else
        result = A.α ^ power
    end
    if i == j
        result += A.δ
    end
    return result
end

# Matrix related functions

issymmetric(A::Chow) = false
ishermitian(A::Chow) = false
