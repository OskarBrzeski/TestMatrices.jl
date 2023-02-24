# TestMatrices

[![Build Status](https://github.com/OskarBrzeski/TestMatrices.jl/actions/workflows/CI.yml/badge.svg?branch=master)](https://github.com/OskarBrzeski/TestMatrices.jl/actions/workflows/CI.yml?query=branch%3Amaster)

This is a package for easily creating a variety of matrices for use in testing algorithms. The package provides a collection of new matrix types to allow utilisation of Julia's multiple dispatch. The types also provide more efficient ways of storing the data which can be converted to the regular Matrix type and vice versa.

## How to use

The package provides types which can be instantiated as such:

```julia
julia> using TestMatrices
julia> A = Toeplitz{Int64}(1, [2, 3], [4, 5])
3×3 Toeplitz{Int64, Vector{Int64}}:
 1  2  3
 4  1  2
 5  4  1
```

Each type can be instantiated in multiple ways, depending on the requirements of the user. It is recommended to include the type of the values when instantiating, but this can be skipped if all of the values can be correctly inferred as being of the same type.

```julia
A = Toeplitz(1+1im, [2+0im, 3+3im], [4+0im, 5+0im])      # this is fine
B = Toeplitz(1+1im, [2, 3+3im], [4, 5])                  # this will result in an error
C = Toeplitz{Complex{Int64}}(1+1im, [2, 3+3im], [4, 5])  # this will convert all arguments to specified type
```

Each type has all the methods needed for a functioning matrix type, as well as some extra for common matrix operations.

```julia
julia> A = Toeplitz(1, [2, 3], [4, 5])
3×3 Toeplitz{Int64, Vector{Int64}}:
 1  2  3
 4  1  2
 5  4  1

julia> transpose(A)
3×3 transpose(::Toeplitz{Int64, Vector{Int64}}) with eltype Int64:
 1  4  5
 2  1  4
 3  2  1
```

You can also generate matrices using the generate function and specifying a matrix type.

```julia
julia> generate(Toeplitz, 1:9, 5, 5)
5×5 Toeplitz{Int64, Vector{Int64}}:
 2  7  9  1  4
 6  2  7  9  1
 6  6  2  7  9
 8  6  6  2  7
 5  8  6  6  2
```