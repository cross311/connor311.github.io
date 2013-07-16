-module(ask_area).
-export([area/0]).

area() ->
  {Input, Shape} = get_shape(),
  case Shape of
    unknown -> io:format("Unknown shape ~c~n",[Input]);
    _ -> get_area(Shape, get_dimensions(Shape))
  end.
  
get_area(_, {error, _}) ->
  io:format("Error in first number.~n");
  
get_area(_, {_, error}) ->
  io:format("Error in second number.~n");

get_area(_, {X, Y}) when X < 0; Y < 0 ->
  io:format("Both number must be greater than or equal to zero.~n");

get_area(Shape, {X, Y}) ->
  geom:area({Shape, X, Y}).

get_shape()  ->
  [Char|_] = io:get_line("R)ectangle, T)riangle, or E)llipse > "),
  char_to_shape(Char).

get_number(Prompt) ->
  PromptString = "Enter " ++ Prompt ++ " > ",
  Result = io:get_line(PromptString),
  string_to_number(Result).

string_to_number(String) ->
  Number = string:to_float(String),
  case Number of
    {error,_} -> element(1, string:to_integer(String));
    _ -> element(1, Number)
  end.

get_dimensions(triangle) ->
  Dimension1 = get_number("width"),
  Dimension2 = get_number("height"),
  {Dimension1, Dimension2};

get_dimensions(rectangle)->
  Dimension1 = get_number("base"),
  Dimension2 = get_number("height"),
  {Dimension1, Dimension2};

get_dimensions(ellipse) ->
  Dimension1 = get_number("axis"),
  Dimension2 = get_number("axis"),
  {Dimension1, Dimension2}.

char_to_shape(Char)  ->
  case Char of
    $T -> {t, triangle};
    $t -> {t, triangle};
    $R -> {r, rectangle};
    $r -> {r, rectangle};
    $E -> {e, ellipse};
    $e -> {e, ellipse};
    _ -> {Char, unknown}
  end.