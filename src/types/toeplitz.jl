import Base.axes
import Base.getindex
import Base.setindex!
import Base.length
import Base.size

"""
    Toeplitz{T, V}(tl::T, row::V, col::V) where {T, V<:AbstractVector{T}}

Type for constructing Toeplitz matrices.

# Examples
```julia-repl
julia> Toeplitz{Int64, Vector{Int64}}(1, [2, 3], [4, 5])
3×3 Toeplitz{Int64, Vector{Int64}}:
 1  2  3
 4  1  2
 5  4  1
```
"""
mutable struct Toeplitz{T, V<:AbstractVector{T}} <: AbstractMatrix{T}
    "Top left value of matrix"
    tl::T
    "First row of matrix, except first value"
    row::V
    "First column of matrix, excpet first value"
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
Toeplitz(tl::T, row::V) where {T, V<:AbstractVector{T}} = Toeplitz(tl, row, row)
function Toeplitz{T}(tl, row::AbstractVector) where {T} 
    conv = convert(AbstractVector{T}, row)
    return Toeplitz(tl, conv, conv)
end

# AbstractArray interface methods

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

@inline function getindex(A::Toeplitz{T}, i::Integer, j::Integer) where T
    @boundscheck checkbounds(A, i, j)
    if i == j
        return @inbounds A.tl
    elseif i < j
        return @inbounds A.row[j - i]
    else
        return @inbounds A.col[i - j]
    end
end

@inline function setindex!(A::Toeplitz, x, i::Integer, j::Integer)
    @boundscheck checkbounds(A, i, j)
    if i == j
        @inbounds A.tl = x
    elseif i < j
        @inbounds A.row[j - i] = x
    else
        @inbounds A.col[i - j] = x
    end
    return x
end

# Matrix related functions

transpose(A::Toeplitz) = Toeplitz(A.tl, A.col, A.row)

adjoint(A::Toeplitz{<:Real}) = transpose(A)
function adjoint(A::Toeplitz)
    tl = conj(A.tl)
    row = conj(A.col)
    col = conj(A.row)
    return Toeplitz(tl, row, col)
end

issymmetric(A::Toeplitz) = A.row == A.col
ishermitian(A::Toeplitz{<:Real}) = issymmetric(A)
ishermitian(A::Toeplitz) = (A.tl.im == 0) & (A.row == conj(A.col))
