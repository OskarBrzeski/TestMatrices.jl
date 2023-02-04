import Base.axes
import Base.getindex
import Base.length
import Base.size

struct Toeplitz{T, V<:AbstractVector{T}} <: AbstractMatrix{T}
    tl::T
    row::V
    col::V
    function Toeplitz{T, V}(tl, row, col) where {T, V<:AbstractVector{T}}
        Base.require_one_based_indexing(row, col)
        new{T, V}(tl, row, col)
    end
end

# Alternate Constructers

Toeplitz(tl::T, row::V, col::V) where {T, V<:AbstractVector{T}} = Toeplitz{T}(tl, row, col)
Toeplitz{T}(tl::T, row::V, col::V) where {T, V<:AbstractVector{T}} = Toeplitz{T, V}(tl, row, col)
function Toeplitz{T}(tl, row::AbstractVector, col::AbstractVector) where {T}
    return Toeplitz(convert(T, tl), convert(AbstractVector{T}, row), convert(AbstractVector{T}, col))
end

# Basic Functions

size(A::Toeplitz) = (length(A.col) + 1, length(A.row) + 1)
function size(A::Toeplitz, d::Integer)
    if d < 0
        throw("dimesntion must be ≥ 1, got $d")
    elseif d ≤ 2
        return size(A)[d]
    else
        return 1
    end
end

axes(A::Toeplitz) = map(Base.OneTo, size(A))
axes(A::Toeplitz, d::Integer) = Base.OneTo(size(A, d))

# AbstractArray interface methods

function getindex(A::Toeplitz{T}, i::Integer, j::Integer) where T
    if i == j
        return A.tl
    elseif i < j
        return A.row[j - i]
    else
        return A.col[i - j]
    end
end

function setindex!(A::Toeplitz{T}, x, i::Integer, j::Integer) where T
    if i == j
        A.tl = x
    elseif i < j
        A.row[j - i] = x
    else
        A.col[i - j] = x
    end
end

# Matrix related calculations

transpose(A::Toeplitz) = Toeplitz(A.tl, A.col, A.row)

adjoint(A::Toeplitz{<:Real}) = transpose(A)
function adjoint(A::Toeplitz)
    tl = conj(A.tl)
    row = map(conj, A.col)
    col = map(conj, A.row)
    return Toeplitz(tl, row, col)
end

issymmetric(A::Toeplitz) = A.row == A.col
ishermitian(A::Toeplitz{<:Real}) = issymmetric(A)
ishermitian(A::Toeplitz) = (A.tl.im == 0) & (A.row == map(conj, A.col))
