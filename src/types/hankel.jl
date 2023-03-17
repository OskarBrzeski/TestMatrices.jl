import Base.axes
import Base.getindex
import Base.size

mutable struct Hankel{T, V<:AbstractVector{T}} <: AbstractMatrix{T}
    row::V
    tr::T
    col::V
    function Hankel{T, V}(row, tr, col) where {T, V<:AbstractVector{T}}
        Base.require_one_based_indexing(row, col)
        new{T, V}(row, tr, col)
    end
end

# Alternate Constructers

Hankel(row::V, tr::T, col::V) where {T, V<:AbstractVector{T}} = Hankel{T}(row, tr, col)
Hankel{T}(row::V, tr::T, col::V) where {T, V<:AbstractVector{T}} = Hankel{T, V}(row, tr, col)
function Hankel{T}(row::AbstractVector, tr, col::AbstractVector) where {T}
    return Hankel(convert(AbstractVector{T}, row), convert(T, tr), convert(AbstractVector{T}, col))
end
Hankel(row::V, tr::T) where {T, V<:AbstractVector{T}} = Hankel(row, tr, row)
function Hankel{T}(row::AbstractVector, tr) where {T} 
    conv = convert(AbstractVector{T}, row)
    return Hankel(conv, tr, conv)
end

# Basic Functions

size(A::Hankel) = (length(A.row) + 1, length(A.row) + 1)
function size(A::Hankel, d::Integer)
    if d < 0
        throw("dimesntion must be ≥ 1, got $d")
    elseif d ≤ 2
        return size(A)[d]
    else
        return 1
    end
end

axes(A::Hankel) = map(Base.OneTo, size(A))
axes(A::Hankel, d::Integer) = Base.OneTo(size(A, d))

# AbstractArray interface methods

@inline function getindex(A::Hankel{T}, i::Integer, j::Integer) where T
    @boundscheck checkbounds(A, i, j)
    if i + j == size(A, 1) + 1
        return @inbounds A.tr
    elseif i + j < size(A, 1) + 1
        return @inbounds A.row[i + j - 1]
    else
        return @inbounds A.col[i + j - 1 - size(A, 1)]
    end
end

@inline function setindex!(A::Hankel, x, i::Integer, j::Integer)
    @boundscheck checkbounds(A, i, j)
    if i + j == size(A, 1) + 1
        @inbounds A.tr = x
    elseif i + j < size(A, 1) + 1
        @inbounds A.row[i + j - 1] = x
    else
        @inbounds A.col[i + j - 1 - size(A, 1)] = x
    end
end

# Matrix related calculations

issymmetric(A::Hankel) = true
ishermitian(A::Hankel{<:Real}) = true
ishermitian(A::Hankel) = false
