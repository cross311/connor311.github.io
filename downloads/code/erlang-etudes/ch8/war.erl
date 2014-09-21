-module(war).
-export ([start/0,start/1]).

start() ->
	start(52).

start(NumberOfCards) when NumberOfCards rem 2 == 0 ->
	Deck = deck:make(NumberOfCards),
	Player1 = spawn(player, play, []),
	Player2 = spawn(player, play, []),
	dealer:deal(Deck, Player1, Player2).
