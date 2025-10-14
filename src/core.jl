module Core

using Symbolics

export time_derivative
time_derivative(u, t) = expand_derivatives(Differential(t)(u))

export symbolically_equal
symbolically_equal(expr1, expr2) = simplify(expr1 - expr2) == 0

export numerically_equal
function numerically_equal(expr1, expr2; vars = Dict(), atol = 1e-8)
  args = collect(keys(vars))
  vals = collect(values(vars))
  f1 = Symbolics.build_function(expr1, args...; expression = false) |> eval
  f2 = Symbolics.build_function(expr2, args...; expression = false) |> eval
  return isapprox(f1(vals...), f2(vals...), atol = atol)
end

end
