-module(deck).
-export([make_deck/0,show_deck/1, shuffle/1]).

make_deck() ->
	Cards = ["A","2","3","4","5","6","7","8","9","10","J","Q","K"],
	Suits = ["Clubs","Diamonds","Hearts","Spades"],
	[{Card, Suit} || Card <- Cards, Suit <- Suits].

show_deck(Deck) ->
	lists:foreach(fun(Card) -> io:format("~p~n", [Card]) end, Deck).

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