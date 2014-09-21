-module (bank).
-export ([account/1]).

-include_lib("eunit/include/eunit.hrl").

account(CurBalance) ->
	account(CurBalance, 
		fun() -> ui:request_action(bank_actions()) end,
		fun(Prompt) -> ui:request_number(Prompt) end).

account(CurBalance, ActionGetterFunc, NumberGetterFunc) ->
	NewBalance = account_handler(
					CurBalance,
					ActionGetterFunc(),
					NumberGetterFunc),
	case NewBalance of
		quit ->
			true;
		_ ->
			account(NewBalance, ActionGetterFunc, NumberGetterFunc)
	end.


account_handler(CurBalance, {Action, Input}, NumberGetterFunc) ->
	case Action of
		deposit_action ->
			deposit(CurBalance, NumberGetterFunc);
		withdraw_action ->
			withdraw(CurBalance, NumberGetterFunc);
		balance_action ->
			balance(CurBalance);
		quit_action ->
			quit;
		unknown_action ->
			io:format("Unknown command ~c~n",[Input]),
			CurBalance
	end.


deposit(CurBalance, NumberGetterFunc) ->
	Amount = NumberGetterFunc("Amount to deposit: "),
	Response = deposit_handler(CurBalance, Amount),
	case Response of
		{error, _} ->
			CurBalance;
		{_, NewBalance} ->
			io:format("Your new balance is ~p~n",[NewBalance]),
			NewBalance
	end.

deposit_handler(_, Amount) when Amount < 0 ->
	io:format("Deposits may not be less than zero.~n"),
	error_logger:error_msg("Negative deposit amount ~p~n",[Amount]),
	{error, negative_amount};

deposit_handler(CurBalance, Amount) when Amount > 10000 ->
	io:format("Your deposit of $~p may be subject to hold.~n",[Amount]),
	error_logger:warning_msg("Excessive deposit ~p~n",[Amount]),
	{warn, CurBalance + Amount};

deposit_handler(CurBalance, Amount) ->
	error_logger:info_msg("Successfull deposit ~p~n",[Amount]),
	{ok, CurBalance + Amount}.



withdraw(CurBalance, NumberGetterFunc) ->
	Amount = NumberGetterFunc("Amount to withdraw: "),
	Response = withdraw_handler(CurBalance, Amount),
	case Response of
		{error, _} ->
			CurBalance;
		{ok, NewBalance} ->
			io:format("Your new balance is ~p~n",[NewBalance]),
			NewBalance
	end.

withdraw_handler(_, Amount) when Amount < 0 ->
	io:format("Withdraws may not be less than zero.~n"),
	error_logger:error_msg("Negative withdraw amount ~p~n",[Amount]),
	{error, negative_amount};

withdraw_handler(CurBalance, Amount) when Amount > CurBalance ->
	io:format("You cannot withdraw more than your current balance of ~p.~n", [CurBalance]),
	error_logger:error_msg("Overdraw ~p from balance ~p~n",[Amount, CurBalance]),
	{error, overdraw};

withdraw_handler(CurBalance, Amount) ->
	error_logger:info_msg("Successfull withdraw ~p~n",[Amount]),
	{ok, CurBalance - Amount}.



balance(CurBalance) ->
	io:format("Your balance is ~p~n",[CurBalance]),
	error_logger:info_msg("Balance inquery ~p~n",[CurBalance]),
	CurBalance.



bank_actions() ->
	[
		{$d, "D)eposit", deposit_action},
		{$w, "W)ithdraw", withdraw_action},
		{$b, "B)alance", balance_action},
		{$q, "Q)uit", quit_action}
	].

%% TESTS %%

deposit_handler_ok_test() ->
	{ok, 2300} = deposit_handler(2000, 300).

deposit_handler_error_negative_test() ->
	{error, negative_amount} = deposit_handler(200, -200).

deposit_handler_high_deposit_test() ->
	{warn, 20000} = deposit_handler(0, 20000).

withdraw_handler_ok_test() ->
	{ok, 2000} = withdraw_handler(2300, 300).

withdraw_handler_error_negative_test() ->
	{error, negative_amount} = withdraw_handler(200, -200).

withdraw_handler_error_overdraw_test() ->
	{error, overdraw} = withdraw_handler(200, 2300).

balance_ok_test() ->
	Expected = 200,
	Expected = balance(Expected).

account_handler_deposit_test() ->
	2300 = account_handler(2000, {deposit_action,$d}, fun(_) -> 300 end).

account_handler_withdraw_test() ->
	2000 = account_handler(2300, {withdraw_action,$w}, fun(_) -> 300 end).

account_handler_balance_test() ->
	2000 = account_handler(2000, {balance_action,$b}, fun(_) -> throw(test_fail) end).

account_handler_quit_test() ->
	quit = account_handler(2000, {quit_action,$q}, fun(_) -> throw(test_fail) end).

account_handler_unknown_test() ->
	2000 = account_handler(2000, {unknown_action,$x}, fun(_) -> throw(test_fail) end).
