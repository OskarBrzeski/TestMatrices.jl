using TestMatrices
using Test

@testset "getindex" begin
    M = Toeplitz(1, [2, 3, 4, 5, 6, 7], [8, 9, 10, 11])
    @test M[1, 1] == 1
    @test M[3, 3] == 1
    @test M[1, 2] == 2
    @test M[3, 4] == 2
    @test M[2, 1] == 8
    @test M[4, 3] == 8
    @test M[4, 6] == 3
end

@testset "setindex!" begin
    M = Toeplitz(1, [2, 3, 4], [5, 6])
    @test M[1, 1] == 1
    M[1, 1] = -1
    @test M[1, 1] == -1
    @test M[1, 2] == 2
    @test M[2, 3] == 2
    M[1, 2] = -2
    @test M[1, 2] == -2
    @test M[2, 3] == -2
    M[2, 3] = 20
    @test M[1, 2] == 20
    @test M[2, 3] == 20
    @test M[2, 1] == 5
    @test M[3, 2] == 5
    M[2, 1] = -5
    @test M[2, 1] == -5
    @test M[3, 2] == -5
    M[3, 2] = 50
    @test M[2, 1] == 50
    @test M[3, 2] == 50
end

@testset "BoundsError" begin
    M = Toeplitz(1, [2, 3, 4, 5, 6, 7], [8, 9, 10, 11])
    @test_throws BoundsError M[6, 1]
    @test_throws BoundsError M[1, 8]
    @test_throws BoundsError M[6, 6]
end

@testset "size" begin
    M = Toeplitz(1, [2, 3, 4, 5, 6, 7], [8, 9, 10, 11])
    @test size(M) == (5, 7)
    @test size(M, 1) == 5
    @test size(M, 2) == 7
    @test size(M, 3) == 1
end

@testset "length" begin
    M = Toeplitz(1, [2, 3, 4, 5, 6, 7], [8, 9, 10, 11])
    @test length(M) == 35 
    M = Toeplitz{Int64}(5, [], [])
    @test length(M) == 1
end

@testset "axes" begin
    M = Toeplitz(1, [2, 3, 4, 5, 6, 7], [8, 9, 10, 11])
    @test axes(M) == (Base.OneTo(5), Base.OneTo(7))
    @test axes(M, 1) == Base.OneTo(5)
    @test axes(M, 2) == Base.OneTo(7)
    @test axes(M, 3) == Base.OneTo(1)
end

@testset "Matrix" begin
    M = Toeplitz(1, [2, 3, 4, 5, 6, 7], [8, 9, 10, 11])
    convertedM = Matrix(M)
    @test typeof(convertedM) == Matrix{Int64}
    @test convertedM[1, 1] == M[1, 1]
    @test convertedM[1, 2] == M[1, 2]
    @test convertedM[3, 4] == M[3, 4]
    @test convertedM[4, 3] == M[4, 3]
    @test convertedM[3, 7] == M[3, 7]
end

@testset "transpose" begin
    M = Toeplitz(1, [2, 3, 4, 5, 6, 7], [8, 9, 10, 11])
    transposeM = transpose(M)
    @test transposeM[1, 1] == M[1, 1]
    @test transposeM[2, 1] == M[1, 2]
    @test transposeM[4, 3] == M[3, 4]
    @test transposeM[3, 4] == M[4, 3]
    @test transposeM[7, 3] == M[3, 7]
    @test size(transposeM) == reverse(size(M))
    @test length(transposeM) == length(M)
    @test axes(transposeM) == reverse(axes(M))
end

@testset "issymmetric" begin
    M = Toeplitz(1, [2, 3], [2, 3])
    @test issymmetric(M)
    M = Toeplitz(1, [2, 3], [4, 5])
    @test ~issymmetric(M)
    M = Toeplitz(1, [2, 3, 4], [2, 3])
    @test ~issymmetric(M)
end

@testset "adjoint" begin
    M = Toeplitz(5im, [-3im, 4], [2-1im, 7, 3])
    adjointM = adjoint(M)
    @test M[1, 1] == conj(adjointM[1, 1])
    @test M[2, 1] == conj(adjointM[1, 2])
    @test M[4, 3] == conj(adjointM[3, 4])
    @test size(adjointM) == reverse(size(M))
    @test length(adjointM) == length(M)
    @test axes(adjointM) == reverse(axes(M))
end

@testset "ishermitian" begin
    M = Toeplitz(5, [2, 4, 7], [2, 4, 7])
    @test ishermitian(M)
    M = Toeplitz(5, [2, 4, 7], [2, 4, 6])
    @test ~ishermitian(M)
    M = Toeplitz{Complex{Int64}}(4, [-3im, 5, 7+2im], [3im, 5, 7-2im])
    @test ishermitian(M)
    M = Toeplitz{Complex{Int64}}(2+2im, [5, 3im], [5, -3im])
    @test ~ishermitian(M)
    M = Toeplitz{Complex{Int64}}(2im, [5, 1im], [5, -1im])
    @test ~ishermitian(M)
    M = Toeplitz{Complex{Int64}}(3+0im, [5, -2im, 6], [5, 2im])
    @test ~ishermitian(M)
end
