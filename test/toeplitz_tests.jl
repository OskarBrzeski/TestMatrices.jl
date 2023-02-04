using TestMatrices
using Test

@testset "Toeplitz indexing" begin
    testM = Toeplitz(1, [2, 3, 4, 5, 6, 7], [8, 9, 10, 11])
    @test testM[1, 1] == 1
    @test testM[3, 3] == 1
    @test testM[1, 2] == 2
    @test testM[3, 4] == 2
    @test testM[2, 1] == 8
    @test testM[4, 3] == 8
    @test testM[4, 6] == 3
end

@testset "Toeplitz size" begin
    testM = Toeplitz(1, [2, 3, 4, 5, 6, 7], [8, 9, 10, 11])
    @test size(testM) == (5, 7)
    @test size(testM, 1) == 5
    @test size(testM, 2) == 7
    @test size(testM, 3) == 1
end

@testset "Toeplitz length" begin
    testM = Toeplitz(1, [2, 3, 4, 5, 6, 7], [8, 9, 10, 11])
    @test length(testM) == 35 
    testM = Toeplitz(5)
    @test length(testM) == 1
end

@testset "Toeplitz axes" begin
    testM = Toeplitz(1, [2, 3, 4, 5, 6, 7], [8, 9, 10, 11])
    @test axes(testM) == (Base.OneTo(5), Base.OneTo(7))
    @test axes(testM, 1) == Base.OneTo(5)
    @test axes(testM, 2) == Base.OneTo(7)
    @test axes(testM, 3) == Base.OneTo(1)
end

@testset "Toeplitz to Matrix" begin
    testM = Toeplitz(1, [2, 3, 4, 5, 6, 7], [8, 9, 10, 11])
    convertedM = Matrix(testM)
    @test typeof(convertedM) == Matrix{Int64}
    @test convertedM[1, 1] == testM[1, 1]
    @test convertedM[1, 2] == testM[1, 2]
    @test convertedM[3, 4] == testM[3, 4]
    @test convertedM[4, 3] == testM[4, 3]
    @test convertedM[3, 7] == testM[3, 7]
end

@testset "Toeplitz transpose" begin
    testM = Toeplitz(1, [2, 3, 4, 5, 6, 7], [8, 9, 10, 11])
    transposeM = transpose(testM)
    @test transposeM[1, 1] == testM[1, 1]
    @test transposeM[2, 1] == testM[1, 2]
    @test transposeM[4, 3] == testM[3, 4]
    @test transposeM[3, 4] == testM[4, 3]
    @test transposeM[7, 3] == testM[3, 7]
    @test size(transposeM) == reverse(size(testM))
    @test length(transposeM) == length(testM)
    @test axes(transposeM) == reverse(axes(testM))
end

@testset "Toeplitz issymmetric" begin
    testM = Toeplitz(1, [2, 3], [2, 3])
    @test issymmetric(testM)
    testM = Toeplitz(1, [2, 3], [4, 5])
    @test ~issymmetric(testM)
    testM = Toeplitz(1, [2, 3, 4], [2, 3])
    @test ~issymmetric(testM)
end

@testset "Toeplitz adjoint" begin
    testM = Toeplitz(5im, [-3im, 4], [2-1im, 7, 3])
    adjointM = adjoint(testM)
    @test testM[1, 1] == conj(adjointM[1, 1])
    @test testM[2, 1] == conj(adjointM[1, 2])
    @test testM[4, 3] == conj(adjointM[3, 4])
    @test size(adjointM) == reverse(size(testM))
    @test length(adjointM) == length(testM)
    @test axes(adjointM) == reverse(axes(testM))
end

@testset "Toeplitz ishermitian" begin
    testM = Toeplitz(5, [2, 4, 7], [2, 4, 7])
    @test ishermitian(testM)
    testM = Toeplitz(5, [2, 4, 7], [2, 4, 6])
    @test ~ishermitian(testM)
    testM = Toeplitz{Complex{Int64}}(4, [-3im, 5, 7+2im], [3im, 5, 7-2im])
    @test ishermitian(testM)
    testM = Toeplitz{Complex{Int64}}(2+2im, [5, 3im], [5, -3im])
    @test ~ishermitian(testM)
    testM = Toeplitz{Complex{Int64}}(2im, [5, 1im], [5, -1im])
    @test ~ishermitian(testM)
    testM = Toeplitz{Complex{Int64}}(3+0im, [5, -2im, 6], [5, 2im])
    @test ~ishermitian(testM)
end
