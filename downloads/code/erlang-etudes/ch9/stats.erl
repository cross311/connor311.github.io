-module(stats).
-export([minimum/1, maximum/1, range/1, mean/1,stdv/1]).

minimum(List) ->
	try minimum(List, hd(list)) of
		Answer -> Answer
	catch
		error:Error -> {error, Error}
	end.

minimum([], ActMin) -> ActMin;
minimum([Head|Tail], CurrMin) ->
	case Head < CurrMin of
		true -> minimum(Tail, Head);
		false -> minimum(Tail, CurrMin)
	end.

maximum(List) ->
	try maximum(List, hd(list)) of
		Answer -> Answer
	catch
		error:Error -> {error, Error}
	end.

maximum([], ActMax) -> ActMax;
maximum([Head|Tail], CurrMax) ->
	case Head > CurrMax of
		true -> maximum(Tail, Head);
		false -> maximum(Tail, CurrMax)
	end.

range(List) -> [minimum(List), maximum(List)].

mean(List) ->
	try
		Length = length(List),
		Sum = lists:foldl(fun(X, Acc) -> X + Acc end, 0, List),
		Sum / Length
	catch
		error:Error -> {error, Error}
	end.

stdv(List) ->
	try
		Length = length(List),
		Sum = lists:foldl(fun(X, Acc) -> X + Acc end, 0, List),
		Sum_Of_Squares = lists:foldl(fun(X, Acc) -> (X*X) + Acc end, 0, List),
		Step5 = (Length * Sum_Of_Squares) - (Sum * Sum),
		Step6 = Step5 / (Length * (Length - 1)),
		math:sqrt(Step6)
	catch
		error:Error -> {error, Error}
	end.
