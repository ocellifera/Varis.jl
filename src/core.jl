module Core

using Symbolics

export time_derivative
function time_derivative(u::Symbolics.Num, t::Symbolics.Num)
  return expand_derivatives(Differential(t)(u))
end

export spatial_gradient
function spatial_gradient(u::Symbolics.Num, x::Symbolics.Num)
  return expand_derivatives(Differential(x)(u))
end
function spatial_gradient(u::Symbolics.Num, x::Symbolics.Num, y::Symbolics.Num)
  return [spatial_gradient(u, x) spatial_gradient(u, y)]
end
function spatial_gradient(
  u::Symbolics.Num,
  x::Symbolics.Num,
  y::Symbolics.Num,
  z::Symbolics.Num,
)
  return [spatial_gradient(u, x) spatial_gradient(u, y) spatial_gradient(u, z)]
end

export spatial_hessian
function spatial_hessian(u::Symbolics.Num, x::Symbolics.Num)
  return spatial_gradient(spatial_gradient(u, x), x)
end
function spatial_hessian(u::Symbolics.Num, x::Symbolics.Num, y::Symbolics.Num)
  return [
    spatial_hessian(u, x) spatial_gradient(spatial_gradient(u, x), y)
    spatial_gradient(spatial_gradient(u, y), x) spatial_hessian(u, y)
  ]
end
function spatial_hessian(
  u::Symbolics.Num,
  x::Symbolics.Num,
  y::Symbolics.Num,
  z::Symbolics.Num,
)
  return [
    spatial_hessian(u, x) spatial_gradient(spatial_gradient(u, x), y) spatial_gradient(spatial_gradient(u, x), z)
    spatial_gradient(spatial_gradient(u, y), x) spatial_hessian(u, y) spatial_gradient(spatial_gradient(u, y), z)
    spatial_gradient(spatial_gradient(u, z), x) spatial_gradient(spatial_gradient(u, z), y) spatial_hessian(u, z)
  ]
end

export symbolically_equal
function symbolically_equal(expr1::Symbolics.Num, expr2::Symbolics.Num)
  return simplify(expr1 - expr2) == 0
end
function symbolically_equal(expr1::Symbolics.Num, expr2::Real)
  return simplify(expr1 - Symbolics.Num(expr2)) == 0
end
function symbolically_equal(expr1::Symbolics.Num, expr2::Integer)
  return simplify(expr1 - Symbolics.Num(expr2)) == 0
end
function symbolically_equal(
  expr1::Matrix{Symbolics.Num},
  expr2::Matrix{Symbolics.Num},
)
  if size(expr1) != size(expr2)
    return false
  end
  for i in eachindex(expr1)
    if !symbolically_equal(expr1[i], expr2[i])
      return false
    end
  end

  return true
end
function symbolically_equal(expr1::Matrix{Symbolics.Num}, expr2::Matrix{<:Real})
  if size(expr1) != size(expr2)
    return false
  end
  for i in eachindex(expr1)
    if !symbolically_equal(expr1[i], expr2[i])
      return false
    end
  end

  return true
end
function symbolically_equal(
  expr1::Matrix{Symbolics.Num},
  expr2::Matrix{<:Integer},
)
  if size(expr1) != size(expr2)
    return false
  end
  for i in eachindex(expr1)
    if !symbolically_equal(expr1[i], expr2[i])
      return false
    end
  end

  return true
end

export numerically_equal
function numerically_equal(
  expr1::Symbolics.Num,
  expr2::Symbolics.Num;
  n_values::Int64 = 10,
  bounds::Tuple{Float64,Float64} = (0.0, 1.0),
  a_tol::Float64 = 1e-8,
)
  for _ in 1:n_values
    subs = Dict{Symbolics.Num,Float64}()
    for var in
        union(Symbolics.get_variables(expr1), Symbolics.get_variables(expr2))
      subs[var] = bounds[1] + (bounds[2] - bounds[1]) * rand(Float64)
    end
    val1 = Symbolics.substitute(expr1, subs) |> Symbolics.value |> Float64
    val2 = Symbolics.substitute(expr2, subs) |> Symbolics.value |> Float64
    if !isapprox(val1, val2; atol = a_tol)
      return false
    end
  end

  return true
end

end
