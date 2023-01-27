using TestMatrices
using Test

testM = Toeplitz([1, 2, 3, 4, 5, 6, 7], [8, 9, 10, 11])

@testset "Toeplitz indexing" begin
    @test testM[1, 1] == 1
    @test testM[3, 3] == 1
    @test testM[1, 2] == 2
    @test testM[3, 4] == 2
    @test testM[2, 1] == 8
    @test testM[4, 3] == 8
    @test testM[4, 6] == 3
end

@testset "Toeplitz size" begin
    @test size(testM) == (5, 7)
    @test size(testM, 1) == 5
    @test size(testM, 2) == 7
    @test size(testM, 3) == 1
end

@testset "Toeplitz length" begin
    @test length(testM) == 35 
end

@testset "Toeplitz axes" begin
    @test axes(testM) == (Base.OneTo(5), Base.OneTo(7))
    @test axes(testM, 1) == Base.OneTo(5)
    @test axes(testM, 2) == Base.OneTo(7)
    @test axes(testM, 3) == Base.OneTo(1)
end

@testset "Toeplitz to Matrix" begin
    convertedM = Matrix(testM)
    @test typeof(convertedM) == Matrix{Int64}
    @test convertedM[1, 1] == testM[1, 1]
    @test convertedM[1, 2] == testM[1, 2]
    @test convertedM[3, 4] == testM[3, 4]
    @test convertedM[4, 3] == testM[4, 3]
    @test convertedM[3, 7] == testM[3, 7]
end

@testset "Toeplitz transpose" begin
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