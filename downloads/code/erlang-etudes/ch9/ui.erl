-module (ui).
-export ([request_number/1, request_action/1]).

-include_lib("eunit/include/eunit.hrl").

-spec(request_number(string()) -> number() | error).
request_number(Prompt) ->
	Result = io:get_line(Prompt),
	Number = string:to_float(Result),
	case Number of
		{error,_} -> element(1, string:to_integer(Result));
		_ -> element(1, Number)
	end.


-spec(request_action(list()) -> {atom(), char()} | {unknown_action, char()}).
request_action(ActionItems) ->
	Prompt = build_action_prompt(ActionItems, ""),
	Char = prompt_for_lowercase_char(Prompt),
	resolve_action_from_char(Char, ActionItems).

build_action_prompt([{_, Prompt, _}|[]], Line) ->
	Line ++ Prompt ++ ": ";
build_action_prompt([{_, Prompt, _}|Tail], Line) ->
	build_action_prompt(Tail, Line ++ Prompt ++ ", ").

prompt_for_lowercase_char(Prompt) ->
	[Char|_] = io:get_line(Prompt),
	string:to_lower(Char).

resolve_action_from_char(Char, []) ->
	{unknown_action, Char};
resolve_action_from_char(Char, [{Char, _, ActionAtom}|_]) ->
	{ActionAtom, Char};
resolve_action_from_char(Char, [{_, _, _}|Tail]) ->
	resolve_action_from_char(Char, Tail).


%% TESTS %%

build_action_prompt_test() ->
	"Y)es, N)o: " = build_action_prompt([{$y,"Y)es", yes_action},{$n,"N)o", no_action}], "").

resolve_action_from_char_ok_test() ->
	{yes_action, $y} = resolve_action_from_char($y, [{$y,"Y)es", yes_action},{$n,"N)o", no_action}]).

resolve_action_from_char_unknown_test() ->
	{unknown_action, $x} = resolve_action_from_char($x, [{$y,"Y)es", yes_action},{$n,"N)o", no_action}]).
