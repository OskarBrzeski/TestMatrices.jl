import Base.axes
import Base.getindex
import Base.setindex!
import Base.length
import Base.size

mutable struct Clement{T, V<:AbstractVector{T}} <: AbstractMatrix{T}
    upper::V
    lower::V
    function Clement{T, V}(upper, lower) where {T, V<:AbstractVector{T}}
        Base.require_one_based_indexing(upper, lower)
        if length(upper) ≠ length(lower)
            throw(ArgumentError("Lengths of arguments do not match"))
        end
        new(upper, lower)
    end
end

# Alternate Constructers

Clement(upper::V, lower::V) where {T, V<:AbstractVector{T}} = Clement{T}(upper, lower)
Clement{T}(upper::V, lower::V) where {T, V<:AbstractVector{T}} = Clement{T, V}(upper, lower)
function Clement{T}(upper::AbstractVector, lower::AbstractVector) where {T}
    return Clement(convert(T, upper), convert(T, lower))
end
Clement(upper::V) where {T, V<:AbstractVector{T}} = Clement(upper, upper)
Clement{T}(upper::AbstractVector) where {T} = Clement(convert(T, upper), convert(T, upper))

# AbstractArray interface methods

size(A::Clement) = (length(A.upper) + 1, length(A.upper) + 1)
function size(A::Clement, d::Integer)
    if d < 0
        throw("dimesntion must be ≥ 1, got $d")
    elseif d ≤ 2
        return size(A)[d]
    else
        return 1
    end
end

@inline function getindex(A::Clement{T}, i::Integer, j::Integer) where T
    @boundscheck checkbounds(A, i, j)
    if i - j == -1
        return @inbounds A.upper[i]
    elseif i - j == 1
        return @inbounds A.lower[j]
    else
        return zero(T)
    end
end

@inline function setindex!(A::Clement, x, i::Integer, j::Integer)
    @boundscheck checkbounds(A, i, j)
    if i - j == -1
        @inbounds A.upper[i] = x
    elseif i - j == 1
        @inbounds A.lower[j] = x
    else
        throw(ArgumentError("Cannot set entry ($i, $j)"))
    end
    return x
end

# Matrix related functions

issymmetric(A::Clement) = A.upper == A.lower
ishermitian(A::Clement{<:Real}) = issymmetric(A)
ishermitian(A::Clement) = A.upper == conj(A.lower)
