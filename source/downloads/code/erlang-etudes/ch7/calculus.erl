-module(calculus).
-export([derivative/2]).


derivative(Func, X) ->
	derivative(Func, X, 1.0e-10).

derivative(Func, X, Delta) ->
	(Func(X + Delta) - Func(X)) / Delta.

