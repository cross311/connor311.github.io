-module (phone_bill).
-export ([init/0,read_bill/1,summary/0,summary/1]).
-include ("phone_records.hrl").

read_to_end(FileLocation) ->
	case file:open(FileLocation, [read]) of
		{error,enoent} ->
			[];
		{ok, File} -> read_to_end(File, [])
	end.

read_to_end({error,enoent}, _) ->
	[];
read_to_end(_, [eof|Lines]) ->
	lists:reverse(Lines);
read_to_end(File, Lines) ->
	read_to_end(File, [io:get_line(File,"")|Lines]).

read_phone_record_from_csv(CsvLine) ->
	[Number,SDate,STime,EDate,ETime|_] = re:split(CsvLine, "[,\n]", [{return,list}]),
	#phone_record{
		phone_number=Number,
		start_date=read_date_time(SDate,STime),
		end_date=read_date_time(EDate,ETime)}.

read_date_time(DateStr, TimeStr) ->
	{parse_three_numbers_crap(re:split(DateStr, "-", [{return,list}])),
	parse_three_numbers_crap(re:split(TimeStr, ":", [{return,list}]))}.

parse_three_numbers_crap(ThreeStringArray) ->
	[{N1,_},{N2,_},{N3,_}] = lists:map(fun(S) -> string:to_integer(S) end, ThreeStringArray),
	{N1,N2,N3}.

diff_date(Date1, Date2) ->
	calendar:datetime_to_gregorian_seconds(Date1) -
		calendar:datetime_to_gregorian_seconds(Date2).

init() ->
	ets:new(phone_record, [named_table, {keypos, #phone_record.phone_number}, bag]).


read_bill(FileLocation) ->
	Records = read_to_end(FileLocation),
	add_calls(Records).

add_calls([]) -> ok;
add_calls([Record|RemainingRecords]) ->
	ets:insert(phone_record, 
		read_phone_record_from_csv(Record)),
	add_calls(RemainingRecords).

summary(PhoneNumber) -> 
	Records = ets:lookup(phone_record,PhoneNumber),
	{PhoneNumber, (
		lists:foldl(fun(R, Sum) -> diff_date(R#phone_record.end_date,R#phone_record.start_date) + Sum end,0,Records)
		+ 59) div 60}.

summary() ->
	summary(ets:first(phone_record),[]).

summary('$end_of_table', List) -> List;
summary(PhoneNumber, List) ->
	summary(ets:next(phone_record, PhoneNumber), [summary(PhoneNumber)|List]).

