using Varis
using Test

@testset "Varis.jl" begin
  @testset "Time derivative" begin
    # Define symbolic variables and equation
    @vars t x
    u = sin(x) * exp(-t)
    calculated = Varis.Core.time_derivative(u, t)
    expected = -sin(x) * exp(-t)

    # Test that the time derivative is symbolically equal 
    @test Varis.Core.symbolically_equal(calculated, expected)

    # Test that the time derivative is numerically equal
    @test Varis.Core.numerically_equal(calculated, expected)
  end
end
