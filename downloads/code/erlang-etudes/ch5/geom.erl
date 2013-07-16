-module(geom).
-export([area/1]).

area({Shape, Height, Width}) when Height >= 0, Width >= 0  ->
  area(Shape, Height, Width).

area(rectangle, Height, Width)->
  Height * Width;
area(triangle, Height, Width) ->
  Height * Width / 2.0;
area(ellipse, Height, Width) ->
  math:pi() * Height * Width;
area(_, _, _) -> 0.