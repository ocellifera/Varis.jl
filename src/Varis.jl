module Varis

export Core
include("core.jl")
using .Core

export GenericFunctions
include("generic_functions.jl")
using .GenericFunctions

using Symbolics
export @vars
macro vars(args...)
  return esc(:(Varis.Symbolics.@variables($(args...))))
end

end
