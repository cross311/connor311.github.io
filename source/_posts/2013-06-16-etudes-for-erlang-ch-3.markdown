---
layout: post
title: "Études for Erlang - CH 3"
date: 2013-06-16 23:01
comments: true
categories: [erlang]
---
It is that time again, well I don't really know if I can say that yet since this is only the second installment of the series.  Last week I wrote about [chapters 1 &amp; 2](/2013/06/14/etudes-for-erlang-ch-1-and-2/) from <a href="http://chimera.labs.oreilly.com/books/1234000000726" target="_blank">Etudes for Erlang</a>, however I actually wrote my solutions after the <a href="http://www.meetup.com/Erlang-NYC/events/122174852/" target="_blank">meetup</a>.  This time I am getting a head start and thankfully I only have to do one chapter. I will just hop right into it, because I am excited to learn some more about Erlang!<!--more-->
<h2>Chapter 3: Atoms, Tuples, and Pattern Matching</h2>
<a href="http://chimera.labs.oreilly.com/books/1234000000726/ch03.html" target="_blank">link</a>

The first part is asking me to update my area function, from last week, to also calculate the area of a triangle, and ellipse not just a rectangle.  The main change it would seem is using pattern matching on a new parameter that is an atom representing the shape.

{% codeblock lang:erlang %}
area(rectangle, Height, Width) ->
	Height * Width;
area(triangle, Height, Width) ->
	Height * Width / 2.0;
area(ellipse, Height, Width) ->
	math:pi() * Height * Width.
{% endcodeblock %}

Output:

{% codeblock lang:erlang %}
3> c(geom).
{ok,geom}
4> geom:area(rectangle, 3,4).
12
5> geom:area(triangle, 3,5).
7.5
6> geom:area(ellipse, 2, 4).
25.132741228718345
{% endcodeblock %}

The second part brings up the fact that our current solution will allow a negative input, while you cannot have a negative area. The recommendation is to use guards. A guard is a when statement after the function signature but before the -&gt;. If you have more then one they can be seporated with commas.

{% codeblock lang:erlang %}
area(rectangle, Height, Width) when Height >= 0, Width >= 0 ->
	Height * Width;
area(triangle, Height, Width) when Height >= 0, Width >= 0  ->
	Height * Width / 2.0;
area(ellipse, Height, Width) when Height >= 0, Width >= 0  ->
	math:pi() * Height * Width.
{% endcodeblock %}

Output:

{% codeblock lang:erlang %}
11> geom:area(rectangle, 3, 4).
12
12> geom:area(ellipse, 2, 3).
18.84955592153876
13> geom:area(rectangle, -1 ,3).
** exception error: no function clause matching geom:area(rectangle,-1,3) (geom.erl, line 14)
{% endcodeblock %}

Onto part three, where our function is now supposed to take in any kind of shape. One catch is that if the function does not support the shape it just returns zero. Seems a little none Erlang (let it fail), but I guess it is a good way to teach underscores. Oh crap, I just gave away the answer... In Erlang an _ in a signature means accept anything.

{% codeblock lang:erlang %}
...
area(ellipse, Height, Width) when Height >= 0, Width >= 0  ->
	math:pi() * Height * Width;
area(_, _, _) ->
	0.
{% endcodeblock %}

Output:

{% codeblock lang:erlang %}
18> geom:area(rectangle, 3,4).
12
19> geom:area(pentagon, 3, 4).
0
20> geom:area(hexagon, -1, 5).
0
21> geom:area(rectangle, 1, -3).
0
{% endcodeblock %}

As you can see, now our negatives return zero even for recognized shapes. This is because the guards are making the pattern match fail, those allowing the catch all case to match and return zero.

The fourth and last part brings Erlang Tuples into the picture. The new requirement is to only have one public facing function, area/1. How are we going to take a 3 parameter function down to only one you ask? By using tuples, which in my mind are the strongly typed messages used in Erlang. While Erlang compiler does not throw error messages like a normal strongly typed languages, the use of tuples, atoms, and pattern matching allow a programmer to specify exactly what he/she wants to come into the function. In this example we will continue to use the shape name as the object type, by making it the first object in the tuple followed by its specs. {shape,number,number}

{% codeblock lang:erlang %}
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
{% endcodeblock %}

Output:

{% codeblock lang:erlang %}
26> geom:area({rectangle, 7, 3}).
21
27> geom:area({triangle, 7, 3}).
10.5
28> geom:area({ellipse, 7, 3}).
65.97344572538566
{% endcodeblock %}

Hope to see you at Erlang-NYC meetup this tuesday (06/18/2013)! Look for next weeks solution to chapters 4 &amp; 5, next sunday .