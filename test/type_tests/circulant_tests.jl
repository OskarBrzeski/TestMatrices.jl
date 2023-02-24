using TestMatrices
using Test

@testset "getindex" begin
    M = Circulant([1, 2, 3, 4, 5, 6, 7])
    @test M[1, 1] == 1
    @test M[1, 2] == 2
    @test M[2, 1] == 7
    @test M[2, 2] == 1
    @test M[6, 3] == 5
end

@testset "setindex!" begin
    M = Circulant([1, 2, 3, 4, 5])
    @test M[1, 1] == 1
    @test M[2, 2] == 1
    M[1, 1] = -1
    @test M[1, 1] == -1
    @test M[2, 2] == -1
    M[2, 2] = 10
    @test M[1, 1] == 10
    @test M[2, 2] == 10
    @test M[1, 2] == 2
    @test M[2, 3] == 2
    M[1, 2] = -2
    @test M[1, 2] == -2
    @test M[2, 3] == -2
    M[2, 3] = 20
    @test M[1, 2] == 20
    @test M[2, 3] == 20
end

@testset "BoundsError" begin
    M = Circulant([1, 2, 3, 4, 5])
    @test_throws BoundsError M[1, 6]
    @test_throws BoundsError M[6, 1]
    @test_throws BoundsError M[6, 6]
end

@testset "size" begin
    M = Circulant([1, 2, 3, 4, 5])
    @test size(M) == (5, 5)
    @test size(M, 1) == 5
    @test size(M, 2) == 5
    @test size(M, 3) == 1
end

@testset "length" begin
    M = Circulant([1, 2, 3, 4, 5])
    @test length(M) == 25
    M = Circulant([1])
    @test length(M) == 1
end

@testset "axes" begin
    M = Circulant([1, 2, 3, 4, 5])
    @test axes(M) == (Base.OneTo(5), Base.OneTo(5))
    @test axes(M, 1) == Base.OneTo(5)
    @test axes(M, 2) == Base.OneTo(5)
    @test axes(M, 3) == Base.OneTo(1)
end

@testset "Matrix" begin
    M = Circulant([1, 2, 3, 4, 5])
    convertedM = Matrix(M)
    @test typeof(convertedM) == Matrix{Int64}
    @test convertedM[1, 1] == M[1, 1]
    @test convertedM[1, 2] == M[1, 2]
    @test convertedM[2, 3] == M[2, 3]
end

@testset "transpose" begin
    M = Circulant([1, 2, 3, 4, 5])
    transposeM = transpose(M)
    @test transposeM[1, 1] == M[1, 1]
    @test transposeM[1, 2] == M[2, 1]
    @test transposeM[4, 2] == M[2, 4]
    @test size(transposeM) == size(M)
    @test length(transposeM) == length(M)
    @test axes(transposeM) == axes(M)
end

@testset "issymmetric" begin
    M = Circulant([1, 2, 3, 4, 5])
    @test ~issymmetric(M)
    M = Circulant([1, 2, 3, 3, 2])
    @test issymmetric(M)
    M = Circulant([1, 2, 3, 4, 3, 2])
    @test issymmetric(M)
end

@testset "adjoint" begin
    M = Circulant([1im, 2-3im, 4, 5+6im, 7-8im])
    adjointM = adjoint(M)
    @test adjointM[1, 1] == conj(M[1, 1])
    @test adjointM[1, 2] == conj(M[2, 1])
    @test adjointM[2, 3] == conj(M[3, 2])
    @test size(adjointM) == size(M)
    @test length(adjointM) == length(M)
    @test axes(adjointM) == axes(M)
end

@testset "ishermitian" begin
    M = Circulant([1, 2, 3, 4, 5])
    @test ~ishermitian(M)
    M = Circulant([1, 2, 3, 3, 2])
    @test ishermitian(M)
    M = Circulant([1im, 2, 3, 3, 2])
    @test ~ishermitian(M)
    M = Circulant([1, 2im, -3im, 3im, -2im])
    @test ishermitian(M)
    M = Circulant([1, 2im, -3im, 4im, 3im, -2im])
    @test ~ishermitian(M)
end