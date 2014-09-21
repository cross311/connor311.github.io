-module(people).
-export([part_one/0
	,part_two/0
	]).

people_list() -> 
	[{"Federico", $M, 22},
	 {"Kim", $F, 45},
	  {"Hansa", $F, 30},
	 {"Tran", $M, 47},
	  {"Cathy", $F, 32},
	   {"Elias", $M, 50}].

part_one() ->
	[{Name, Gender, Age} || {Name, Gender, Age} <- people_list(), Gender == $M, Age > 40].

part_two() ->
	[{Name, Gender, Age} || {Name, Gender, Age} <- people_list(), (Gender == $M) or (Age > 40)].