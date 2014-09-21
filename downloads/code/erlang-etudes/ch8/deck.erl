-module(deck).
-export([make/1, show_deck/1, compare/2, make_deck/0]).


make(SizeOfDeck) when SizeOfDeck =< 52 ->
	{ReturnDeck, _} = lists:split(SizeOfDeck, shuffle(make_deck())),
	ReturnDeck.

show_deck(Deck) ->
	lists:foreach(fun({_,DisplayValue, Suit}) -> 
		io:format("~p of ~p~n", [DisplayValue, Suit]) end, Deck).

compare({Card1Value, _,_}, {Card2Value, _,_}) ->
	Card1Value - Card2Value.

%% PRIVATE %%

make_deck() ->
	Cards = 
	[{"2",2},
	{"3",3},
	{"4",4},
	{"5",5},
	{"6",6},
	{"7",7},
	{"8",8},
	{"9",9},
	{"10",10},
	{"J",11},
	{"Q",12},
	{"K",13},
	{"A", 14}],
	Suits = 
	["Clubs",
	"Diamonds",
	"Hearts",
	"Spades"],

	[{Value, DisplayValue,Suit} || 
		{DisplayValue, Value} <- Cards,
		Suit <- Suits].

%%%
% Get the Accumulator Setup
%%
shuffle(List) -> shuffle(List, []).

%%
% Break recurssion once we have gone through
% the whole deck
%%
shuffle([], Acc) -> Acc;

%%
% Shuffle the remaining deck
% still left in List
%%
shuffle(List, Acc) ->
	%% Split the deck at a random point
	%% then on the second part of the split
	%% take the top card and put at the begining of
	%% out shuffled pill (Acc)
	{Leading, [H | T]} = lists:split(random:uniform(length(List)) - 1, List),
	shuffle(Leading ++ T, [H | Acc]).