-module (player).
-export ([play/0]).

play() ->
	listen_loop([]).

listen_loop(Cards) ->
	NumberOfCards = length(Cards),
	receive
		{_, hand, NewCards} ->
			listen_loop(NewCards);

		{From, send_cards, N} when N =< NumberOfCards ->
			{Hand, LeftCards} = lists:split(N, Cards),
			From ! {self(), send_hand, Hand},
			listen_loop(LeftCards);

		{From, send_cards, N} when N > NumberOfCards ->
			From ! {self(), send_hand, []},
			listen_loop(Cards);

		{_, won_hand, Pile} ->
			listen_loop(Pile ++ Cards);

		{From, send_count} ->
			From ! {self(), send_count, NumberOfCards},
			listen_loop(Cards)
	end.		
