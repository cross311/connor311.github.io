-module(ask_area).
-export([area/0]).

area() ->
  Shape = get_shape(),
  get_area(Shape).

get_area(Shape) -> 
  Dimensions = get_dimensions(Shape),
  geom:area({Shape, element(1, Dimensions), element(2, Dimensions)}).

get_shape()  ->
  [Char|] = io:get_line("R)ectangle, T)riangle, or E)llipse > ", 1),
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
  {Dimension1, Dimension2};

get_dimensions(_) ->
  io:format("Unknown shape"),
  {0,0}.

char_to_shape(Char)  ->
  case Char of
    $T -> triangle;
    $t -> triangle;
    $R -> rectangle;
    $r -> rectangle;
    $E -> ellipse;
    $e -> ellipse;
    _ -> unknown
  end.