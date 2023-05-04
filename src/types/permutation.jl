import Base.axes
import Base.getindex
import Base.setindex!
import Base.length
import Base.size

struct Permutation{T, V<:AbstractVector{T}} <: AbstractMatrix{Integer}
    cols::V
    function Permutation{T, V}(cols) where {T, V<:AbstractVector{T}}
        Base.require_one_based_indexing(cols)
        if sort(cols) ≠ 1:length(cols)
            throw(ArgumentError("Vector must be permutation of 1:n"))
        end
        new(cols)        
    end
end

# Alternate Constructers

Permutation(cols::V) where {T, V<:AbstractVector{T}} = Permutation{T}(cols)
Permutation{T}(cols::V) where {T, V<:AbstractVector{T}} = Permutation{T, V}(cols)

# AbstractArray interface methods

size(A::Permutation) = (length(A.cols), length(A.cols))
function size(A::Permutation, d::Integer)
    if d < 0
        throw("dimesntion must be ≥ 1, got $d")
    elseif d ≤ 2
        return size(A)[d]
    else
        return 1
    end
end

@inline function getindex(A::Permutation, i::Integer, j::Integer)
    @boundscheck checkbounds(A, i, j)
    if @inbounds A.cols[j] == i
        return 1
    else
        return 0
    end
end

# Matrix related functions

issymmetric(A::Permutation) = (A.cols == 1:length(A.cols)) | (A.cols == length(A.cols):-1:1)
ishermitian(A::Permutation) = issymmetric(A)
