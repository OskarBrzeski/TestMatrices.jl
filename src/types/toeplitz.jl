import Base.axes
import Base.getindex
import Base.length
import Base.size


struct Toeplitz{T, V<:AbstractVector{T}} <: AbstractMatrix{T}
    row::V
    col::V
    function Toeplitz{T, V}(row, col) where {T, V<:AbstractVector{T}}
        Base.require_one_based_indexing(row, col)
        new{T, V}(row, col)
    end
end

# Alternate Constructers

Toeplitz(row::V, col::V) where {T, V<:AbstractVector{T}} = Toeplitz{T}(row, col)
Toeplitz{T}(row::V, col::V) where {T, V<:AbstractVector{T}} = Toeplitz{T, V}(row, col)

# Basic Functions

size(A::Toeplitz) = (length(A.col) + 1, length(A.row))
function size(A::Toeplitz, d::Integer)
    if d < 0
        throw("dimesntion must be ≥ 1, got $d")
    elseif d ≤ 2
        return size(A)[d]
    else
        return 1
    end
end

length(A::Toeplitz) = prod(size(A))

axes(A::Toeplitz) = (Base.OneTo(length(A.col) + 1), Base.OneTo(length(A.row)))
function axes(A::Toeplitz, d::Integer)
    if d < 0
        throw("dimension must be ≥ 1, got $d")
    elseif d ≤ 2
        return axes(A)[d]
    else
        return Base.OneTo(1)
    end
end

# AbstractArray interface methods

function getindex(A::Toeplitz{T}, i::Integer, j::Integer) where T
    if i == j
        return A.row[1]
    elseif i < j
        return A.row[j - i + 1]
    else
        return A.col[i - j]
    end
end

function setindex!(A::Toeplitz{T}, x, i::Integer, j::Integer) where T
    if i == j
        A.row[0] = x
    elseif i < j
        A.row[j - i + 1] = x
    else
        A.col[i - j] = x
    end
end

# Matrix related calculations

transpose(A::Toeplitz) = Toeplitz([A.row[1], A.col...], A.row[2:end])