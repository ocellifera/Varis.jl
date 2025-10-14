using Varis
using Test

@testset "Varis.jl" begin
  @testset "Time derivative" begin
    # Define symbolic variables and equation
    @vars t x
    u = sin(x) * exp(-t)
    du_dt = Varis.Core.time_derivative(u, t)

    # Test that the time derivative is symbolically equal 
    @test Varis.Core.symbolically_equal(du_dt, -sin(x) * exp(-t))
  end
end
