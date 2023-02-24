import Base.axes
import Base.getindex
import Base.setindex!
import Base.length
import Base.size

struct Circulant{T, V<:AbstractVector{T}} <: AbstractMatrix{T}
    row::V
    function Circulant{T, V}(row) where {T, V<:AbstractVector{T}}
        Base.require_one_based_indexing(row)
        new{T, V}(row)
    end
end

# Alternate Constructers

Circulant(row::V) where {T, V<:AbstractVector{T}} = Circulant{T}(row,)
Circulant{T}(row::V) where {T, V<:AbstractVector{T}} = Circulant{T, V}(row)

# Basic Functions

size(A::Circulant) = (length(A.row), length(A.row))
function size(A::Circulant, d::Integer)
    if d < 0
        throw("dimesntion must be ≥ 1, got $d")
    elseif d ≤ 2
        return length(A.row)
    else
        return 1
    end
end

axes(A::Circulant) = map(Base.OneTo, size(A))
axes(A::Circulant, d::Integer) = Base.OneTo(size(A, d))

# AbstractArray interface methods

@inline function getindex(A::Circulant{T}, i::Integer, j::Integer) where T
    @boundscheck checkbounds(A, i, j)
    return @inbounds A.row[mod(j - i, length(A.row)) + 1]
end

@inline function setindex!(A::Circulant{T}, x, i::Integer, j::Integer) where T
    @boundscheck checkbounds(A, i, j)
    @inbounds A.row[mod(j - i, length(A.row)) + 1] = x
end

# Matrix related calculations

transpose(A::Circulant) = Circulant([A.row[1], reverse(A.row[2:end])...])

adjoint(A::Circulant{<:Real}) = transpose(A)
function adjoint(A::Circulant)
    row = conj(reverse(A.row[2:end]))
    return Circulant([conj(A.row), row...])
end

issymmetric(A::Circulant) = A.row[2:end] == reverse(A.row[2:end])
ishermitian(A::Circulant{<:Real}) = issymmetric(A)
ishermitian(A::Circulant) = (A.row[1].im == 0) & (A.row[2:end] == conj(reverse(A.row[2:end])))
