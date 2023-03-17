import Base.axes
import Base.getindex
import Base.size

struct Hilbert <: AbstractMatrix{Rational}
    size::Integer
    function Hilbert(size::Integer)
        new(size)
    end
end

# Basic Functions

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

axes(A::Hilbert) = (Base.OneTo(A.size), Base.OneTo(A.size))
axes(A::Hilbert, d::Integer) = Base.OneTo(size(A, d))

# AbstractArray interface methods

@inline function getindex(A::Hilbert, i::Integer, j::Integer)
    @boundscheck checkbounds(A, i, j)
    return @inbounds 1 // (i + j - 1)
end

# Matrix related calculations

issymmetric(A::Hilbert) = true
ishermitian(A::Hilbert) = true
