module Core

using Symbolics

export time_derivative
function time_derivative(u, t)
    return expand_derivatives(Differential(t)(u))
end

export symbolically_equal
function symbolically_equal(expr1, expr2)
    return simplify(expr1 - expr2) == 0
end

export numerically_equal
function numerically_equal(expr1, expr2; vars=Dict(), atol=1e-8)
    args = collect(keys(vars))
    vals = collect(values(vars))
    f1 = Symbolics.build_function(expr1, args...; expression=false) |> eval
    f2 = Symbolics.build_function(expr2, args...; expression=false) |> eval
    return isapprox(f1(vals...), f2(vals...), atol=atol)
end

end
