import Base.axes
import Base.getindex
import Base.size

struct Hilbert <: AbstractMatrix{Rational}
    size::Integer
    function Hilbert(size::Integer)
        new(size)
    end
end

# AbstractArray interface methods

size(A::Hilbert) = (A.size, A.size)
function size(A::Hilbert, d::Integer)
    if d < 0
        throw("dimesntion must be ≥ 1, got $d")
    elseif d ≤ 2
        return A.size
    else
        return 1
    end
end

@inline function getindex(A::Hilbert, i::Integer, j::Integer)
    @boundscheck checkbounds(A, i, j)
    return @inbounds 1 // (i + j - 1)
end

# Matrix related functions

issymmetric(A::Hilbert) = true
ishermitian(A::Hilbert) = true
