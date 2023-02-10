using TestMatrices
using Test

@testset "Circulant indexing" begin
    testM = Circulant([1, 2, 3, 4, 5, 6, 7])
    @test testM[1, 1] == 1
    @test testM[1, 2] == 2
    @test testM[2, 1] == 7
    @test testM[2, 2] == 1
    @test testM[6, 3] == 5
end