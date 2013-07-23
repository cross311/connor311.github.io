-module(dealer).
-export ([deal/3]).

deal(Deck, Player1, Player2) ->
	{Player1Cards, Player2Cards} = lists:split(length(Deck) div 2, Deck),
	Player1 ! {self(), hand, Player1Cards},
	Player2 ! {self(), hand, Player2Cards},
	start_hand(Player1, Player2).

start_hand(Player1,Player2) ->
	Player1 ! {self(), send_cards, 1},
	Player2 ! {self(), send_cards, 1},
	get_hand(Player1, Player2, []).

start_war(Player1,Player2, Pile) ->
	Player1 ! {self(), send_cards, 3},
	Player2 ! {self(), send_cards, 3},
	get_hand(Player1,Player2, Pile).

get_hand(Player1, Player2, Pile)  ->
	hand_loop({Player1, []},{Player2, []}, Pile).

await_hand({Player1, Player1Hand},{Player2, []}, Pile)  ->
	hand_loop({Player1, Player1Hand},{Player2, []}, Pile);

await_hand({Player1, []},{Player2, Player2Hand}, Pile)  ->
	hand_loop({Player1, []},{Player2, Player2Hand}, Pile);

await_hand({Player1, Player1Hand},
			{Player2, Player2Hand},
			Pile) ->
	[Player1HandH | Player1HandT] = lists:reverse(Player1Hand),
	[Player2HandH | Player2HandT] = lists:reverse(Player2Hand),
	Compare = deck:compare(Player1HandH, Player2HandH),
	NewPile = Pile ++ [Player1HandH | Player1HandT] ++ [Player2HandH | Player2HandT],
	
	if	Compare > 0 -> 
			io:format("Player 1 wins hand. ~p vs ~p~n",[Player1HandH, Player2HandH]),
			Player1 ! {self(), won_hand, NewPile},
			get_count(Player1, Player2);
		Compare < 0 -> 
			io:format("Player 2 wins hand. ~p vs ~p~n",[Player1HandH, Player2HandH]),
			Player2 ! {self(), won_hand, NewPile},
			get_count(Player1, Player2);
		Compare == 0 ->
			io:format("Start War. ~p vs ~p~n",[Player1HandH, Player2HandH]),
			start_war(Player1, Player2, NewPile)
	end.


hand_loop({Player1, Player1Hand},{Player2, Player2Hand}, Pile) ->
	receive
		{Player1, send_hand ,[]} ->
			io:format("Player 1 is out of cards.~n", []),
			winner("Player 2", Player2, Player1, Player2Hand ++ Pile);
		{Player2, send_hand,[]} ->
			io:format("Player 2 is out of cards.~n", []),
			winner("Player 1", Player1, Player2, Player1Hand ++ Pile);

		{Player1, send_hand ,Cards} ->
			io:format("Player 1 sent hand ~p.~n", [Cards]),
			await_hand({Player1, Cards},{Player2, Player2Hand}, Pile);
		{Player2, send_hand ,Cards} ->
			io:format("Player 2 sent hand ~p.~n", [Cards]),
			await_hand({Player1, Player1Hand},{Player2, Cards}, Pile)
	end.

get_count(Player1, Player2) ->
	Player1 ! {self(), send_count},
	Player2 ! {self(), send_count},
	count_loop({Player1, -1},
			{Player2, -1}).

await_count({Player1, Player1Count},
			{Player2, -1}) ->
	count_loop({Player1, Player1Count},
			{Player2, -1});

await_count({Player1, -1},
			{Player2, Player2Count}) ->
	count_loop({Player1, -1},
			{Player2, Player2Count});

await_count({Player1, Player1Count},
			{Player2, Player2Count}) ->
	io:format("Player 1: ~p, Player 2: ~p.~n",[Player1Count, Player2Count]),
	start_hand(Player1, Player2).

count_loop({Player1, Player1Count},
			{Player2, Player2Count}) ->
	receive
		{Player1, send_count, Num} ->
			await_count({Player1, Num},{Player2, Player2Count});
		{Player2, send_count, Num} ->
			await_count({Player1, Player1Count},{Player2, Num})
	end.


winner(PlayerName, _WinningPlayer, _LosingPlayer, _LootPile) ->
	io:format("Game Over ~p Wins!~n",[PlayerName]).
