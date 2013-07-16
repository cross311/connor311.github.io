-module(dates).
-export([date_parts/1]).

date_parts(Date) ->
  [Year, Month, Day] = re:split(Date, "-", [{return, list}]),
  {element(1,string:to_integer(Year)),
   element(1,string:to_integer(Month)),
   element(1,string:to_integer(Day))}.