using Varis
using Test

@testset "Varis.jl" begin
  @testset "Simple scalar time derivative" begin
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

  @testset "Simple scalar spatial gradient 1D" begin
    # Define symbolic variables and equation
    @vars x u(x)
    u = x^2
    calculated = Varis.Core.spatial_gradient(u, x)
    expected = 2x

    # Test that the spatial gradient is symbolically equal 
    @test Varis.Core.symbolically_equal(calculated, expected)
  end

  @testset "Simple scalar spatial gradient 2D" begin
    # Define symbolic variables and equation
    @vars x y u(x, y)
    u = x^2 + y^2
    calculated = Varis.Core.spatial_gradient(u, x, y)
    expected = [2x 2y]

    # Test that the spatial gradient is symbolically equal 
    @test Varis.Core.symbolically_equal(calculated, expected)
  end

  @testset "Simple scalar spatial gradient 3D" begin
    # Define symbolic variables and equation
    @vars x y z u(x, y, z)
    u = x^2 + y^2 + z^2
    calculated = Varis.Core.spatial_gradient(u, x, y, z)
    expected = [2x 2y 2z]

    # Test that the spatial gradient is symbolically equal 
    @test Varis.Core.symbolically_equal(calculated, expected)
  end

  @testset "Simple scalar spatial hessian 1D" begin
    # Define symbolic variables and equation
    @vars x u(x)
    u = x^2
    calculated = Varis.Core.spatial_hessian(u, x)
    expected = 2

    # Test that the spatial gradient is symbolically equal 
    @test Varis.Core.symbolically_equal(calculated, expected)
  end

  @testset "Simple scalar spatial hessian 2D" begin
    # Define symbolic variables and equation
    @vars x y u(x, y)
    u = x^2 + y^2
    calculated = Varis.Core.spatial_hessian(u, x, y)
    expected = [2 0; 0 2]

    # Test that the spatial gradient is symbolically equal 
    @test Varis.Core.symbolically_equal(calculated, expected)
  end

  @testset "Simple scalar spatial hessian 3D" begin
    # Define symbolic variables and equation
    @vars x y z u(x, y, z)
    u = x^2 + y^2 + z^2
    calculated = Varis.Core.spatial_hessian(u, x, y, z)
    expected = [2 0 0; 0 2 0; 0 0 2]

    # Test that the spatial gradient is symbolically equal 
    @test Varis.Core.symbolically_equal(calculated, expected)
  end
end
