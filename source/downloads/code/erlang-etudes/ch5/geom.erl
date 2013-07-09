-module(geom).
-export([area/1]).

area({Shape, Height, Width}) ->
  area(Shape, Height, Width).

area(rectangle, Height, Width) when Height >= 0, Width >= 0 ->
  Height * Width;
area(triangle, Height, Width) when Height >= 0, Width >= 0  ->
  Height * Width / 2.0;
area(ellipse, Height, Width) when Height >= 0, Width >= 0  ->
  math:pi() * Height * Width;
area(_, _, _) ->
  0.