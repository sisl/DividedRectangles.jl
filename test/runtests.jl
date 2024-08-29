using Test
using DividedRectangles

# Test function: simple quadratic function with minimum at origin
function quadratic_bowl(x)
    return sum(x.^2)  # Minimum is at the origin [0.0, 0.0, ...] with value 0.0
end

# Test function: more complex function with multiple local minima
function complex_function(x)
    return sin(5 * x[1]) * cos(3 * x[2]) + sum(x.^2)  # A function with local minima
end

# Test set for the DIRECT Algorithm
@testset "DIRECT Algorithm Tests" begin

    # Test 1: Basic functionality with 2D space
    @testset "2D Optimization Test" begin
        a = [0.0, 0.0]  # Lower bounds of the search space
        b = [1.0, 1.0]  # Upper bounds of the search space
        
        result = optimize(quadratic_bowl, a, b, max_iterations=10, min_radius=1e-3)

        # Ensure the result is within the bounds
        @test 0.0 <= result[1] <= 1.0
        @test 0.0 <= result[2] <= 1.0
        # Check if the function value at the result is close to the known minimum (0.0)
        @test isapprox(quadratic_bowl(result), 0.0, atol=1e-3)
    end

    # Test 2: Test for a 3D space
    @testset "3D Optimization Test" begin
        a = [0.0, 0.0, 0.0]
        b = [1.0, 1.0, 1.0]
        
        result = optimize(quadratic_bowl, a, b, max_iterations=20, min_radius=1e-3)

        # Ensures the result is within the bounds for all dimensions
        @test 0.0 <= result[1] <= 1.0
        @test 0.0 <= result[2] <= 1.0
        @test 0.0 <= result[3] <= 1.0
        @test isapprox(quadratic_bowl(result), 0.0, atol=1e-3)
    end

    # Test 3: Check edge cases where the search space is very narrow
    @testset "Narrow Search Space Test" begin
        a = [0.0, 0.0]
        b = [0.1, 0.1]  # Narrow bounds
        
        result = optimize(quadratic_bowl, a, b, max_iterations=10, min_radius=1e-4)

        # Ensure the result is within the narrow bounds
        @test 0.0 <= result[1] <= 0.1
        @test 0.0 <= result[2] <= 0.1
        @test isapprox(quadratic_bowl(result), 0.0, atol=1e-3)
    end

    # Test 4: Test with more iterations and smaller min_radius for higher precision
    @testset "High Precision Test" begin
        a = [0.0, 0.0]
        b = [1.0, 1.0]
        
        result = optimize(quadratic_bowl, a, b, max_iterations=100, min_radius=1e-5)

        # Ensure the result is within the bounds and the optimizer achieves high precision
        @test 0.0 <= result[1] <= 1.0
        @test 0.0 <= result[2] <= 1.0
        @test isapprox(quadratic_bowl(result), 0.0, atol=1e-5)
    end

    # Test 5: Test for a non-quadratic function with local minima
    @testset "Non-Quadratic Function Test" begin
        a = [0.0, 0.0]
        b = [1.0, 1.0]
        
        result = optimize(complex_function, a, b, max_iterations=50, min_radius=1e-4)

        # Ensure the result is within the bounds for the complex function
        @test 0.0 <= result[1] <= 1.0
        @test 0.0 <= result[2] <= 1.0
    end

end
