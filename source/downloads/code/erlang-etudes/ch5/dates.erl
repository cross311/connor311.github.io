-module(dates).
-export([data_parts/1]).

data_parts(Date) ->
  [Year, Month, Day] = re:split(Date, "-", [{return, list}]),
  [element(1,string:to_integer(Year)),
   element(1,string:to_integer(Month)),
   element(1,string:to_integer(Day))].