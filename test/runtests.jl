using Test

using DividedRectangles

function test_function(x)
    return sum(x.^2)  
end

@testset "DIRECT Algorithm Tests" begin
    a = [0.0, 0.0]
    b = [1.0, 1.0]
 
    result = direct(test_function, a, b, 10, 1e-3)

    @test 0.0 <= result[1] <= 1.0
    @test 0.0 <= result[2] <= 1.0
end



