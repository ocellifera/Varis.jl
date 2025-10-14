using Varis
using Test

@testset "Varis.jl" begin
  @testset "Time derivative" begin
    @vars t x
    u = sin(x) * exp(-t)
    du_dt = Varis.Core.time_derivative(u, t)
    @test Varis.Core.symbolically_equal(du_dt, -sin(x) * exp(-t))
    @test Varis.Core.numerically_equal(
      du_dt,
      -sin(x) * exp(-t);
      vars = Dict(t => 0.5, x => 1.0),
    )
  end
end
