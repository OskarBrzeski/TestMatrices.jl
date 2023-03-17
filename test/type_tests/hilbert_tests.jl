using TestMatrices
using Test

@testset "getindex" begin
    M = Hilbert(5)
    @test M[1, 1] == 1
    @test M[1, 2] == 1 // 2
    @test M[2, 1] == 1 // 2
    @test M[2, 2] == 1 // 3
    @test M[4, 2] == 1 // 5
    @test M[5, 5] == 1 // 9 
end

@testset "boundscheck" begin
    M = Hilbert(5)
    @test_throws BoundsError M[1, 6]
    @test_throws BoundsError M[6, 1]
    @test_throws BoundsError M[6, 6]
end

@testset "size" begin
    M = Hilbert(5)
    @test size(M) == (5, 5)
    @test size(M, 1) == 5
    @test size(M, 2) == 5
    @test size(M, 3) == 1
end

@testset "length" begin
    M = Hilbert(5)
    @test length(M) == 25
end

@testset "axes" begin
    M = Hilbert(5)
    @test axes(M) == (Base.OneTo(5), Base.OneTo(5))
    @test axes(M, 1) == Base.OneTo(5)
    @test axes(M, 2) == Base.OneTo(5)
    @test axes(M, 3) == Base.OneTo(1)
end

@testset "Matrix" begin
    M = Hilbert(5)
    convertedM = Matrix(M)
    @test M[1, 1] == convertedM[1, 1]
    @test M[2, 3] == convertedM[2, 3]
    @test M[4, 1] == convertedM[4, 1]
end
