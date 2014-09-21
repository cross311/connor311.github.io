-module(stats).
-export([mean/1,stdv/1]).

mean([]) -> 0;
mean(List) ->
	Length = length(List),
	Sum = lists:foldl(fun(X, Acc) -> X + Acc end, 0, List),
	Sum / Length.

stdv([]) -> 0;
stdv(List) ->
	Length = length(List),
	Sum = lists:foldl(fun(X, Acc) -> X + Acc end, 0, List),
	Sum_Of_Squares = lists:foldl(fun(X, Acc) -> (X*X) + Acc end, 0, List),
	Step5 = (Length * Sum_Of_Squares) - (Sum * Sum),
	Step6 = Step5 / (Length * (Length - 1)),
	math:sqrt(Step6).
