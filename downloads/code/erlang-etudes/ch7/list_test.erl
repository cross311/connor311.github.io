-module(list_test).
-export([seven_four/1,seven_five/0]).

seven_four(test1) -> 
	lists:split(4, [110,220,330,440,550,660]);

seven_four(test2) -> 
	lists:split(0, [110,220,330,440,550,660]).

seven_five() ->
	[X * Y || X <- [3, 5, 7], Y <- [2, 4, 6]].