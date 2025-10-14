module Core

using Symbolics

export time_derivative
function time_derivative(u::Symbolics.Num, t::Symbolics.Num)
  return expand_derivatives(Differential(t)(u))
end

export symbolically_equal
function symbolically_equal(expr1::Symbolics.Num, expr2::Symbolics.Num)
  return simplify(expr1 - expr2) == 0
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
