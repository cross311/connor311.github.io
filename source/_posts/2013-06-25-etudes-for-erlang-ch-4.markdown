---
layout: post
title: "Études for Erlang - CH 4"
date: 2013-06-25 23:26
comments: true
categories: [erlang]
---
This week the homework for the <a href="http://www.meetup.com/Erlang-NYC/events/123394132/" target="_blank">meetup</a> was chapters 4 &amp; 5.  However this weekend I was at my childhood best friend's bachelor party so I only got to chapter 4. Ouch, Ouch, please stop throwing tomatoes, lettuce and actually I don't want to know what that is, I am sorry!  If you want more Erlang check out last week for [chapter 3](/2013/06/16/etudes-for-erlang-ch-3/)</a>, again!

The party was a blast I got to play Frisbee golf for the first time in real life, it was awesome.  The other plus was the party's location was in Richmond, VA, so I got to rent a car and drive all the way there.  For those of you who do not know me, I LOVE TO DRIVE!!!  I specifically went to a rental company just because I heard they had VW Jettas for rent.  Must say, this whole better gas mileage kick the auto industry is on really makes driving automatics suck.  Give me a manual any day.

Oh wow I really got off track, my B.<!--more-->
<h2>Chapter 4: Logic and Recursion</h2>
<a href="http://chimera.labs.oreilly.com/books/1234000000726/ch04.html" target="_blank">link</a>

The first task this week was super simple, change last weeks area function into an Erlang case statement.  Since case statements are just pattern matches, the two are almost identical.

{% codeblock lang:erlang %}
%% @author C J Ross <connor311@gmail.com>
%% @doc Functions for calculating areas of geometric shapes.
%% @copyright 2013 C J Ross
%% @version 0.1

-module(geom).
-export([area/1]).

-spec(area({atom(), number(),number()}) -> number()).
area({Shape, Height, Width}) when Height >= 0, Width >= 0 ->
	case Shape of
		rectangle  ->
			Height * Width;
		triangle ->
			Height * Width / 2.0;
		ellipse ->
			math:pi() * Height * Width;
		_ ->
			0
	end.
{% endcodeblock %}

The main topic for this week is introduced in task two, Recursion!  The task, Greatest Common Divisor, makes me sentimental a little bit. I don't know about you, but GCD was the first program I had to write recursion for in college.  Again, another easy problem as to not jump into a freezing pool all at once.

{% codeblock lang:erlang %}
%% @author C J Ross <connor311@gmail.com>
%% @doc Functions for calculating GCD.
%% @copyright 2013 C J Ross
%% @version 0.1

-module(dijkstra).
-export([gcd/2]).

-spec(gcd(number(), number()) -> number()).
gcd(M, N) ->
	if M == N -> M;
	   M > N -> gcd(M-N, N);
	   M < N -> gcd(M, N - M)
	end.
{% endcodeblock %}

One of the big sellers for Erlang is an idea of Tail Recursion. This is a language concept that allows recursion with out worries of overflowing the stack (the main concern of recursion).  My co-worker and good pal, Steve, nicely informed me that most languages actually implement this feature.  Makes me feel like a dummy for thinking Erlang was the cool kid on the block for implementing this.  


The objective for for task three is to not use tail-recursion, then later compare to an actual tail-recursion version. The math function of choice for this task, is to raise a number to another number. X to the power of N, or 2 to the power of 2 equals 4.

{% codeblock lang:erlang %}
%% @author C J Ross <connor311@gmail.com>
%% @doc Functions for calculating powers
%% @copyright 2013 C J Ross
%% @version 0.1

-module(powers).
-export([raise/2]).

-spec(raise(number(), number()) -> number()).
raise(_, 0) ->
	1;
raise(X, 1) ->
	X;
raise(X, N) when N > 1 ->
	X * raise(X, N-1);
raise(X, N) when N < 0 ->
	1 / raise(X, -N).
{% endcodeblock %}

Now as promised, the tail-recursive version.  The first noticeable difference is the addition of a helper function to accumulate the answer. This is common practice since the caller of the public method will not know what to start the accumulator variable as, nor should they.  Notice how the main return with recursion just calls a method and returns its return.  If any kind of modifications was done with the return, this method would not longer be tail-recursive.

{% codeblock lang:erlang %}
%% @author C J Ross <connor311@gmail.com>
%% @doc Functions for calculating powers
%% @copyright 2013 C J Ross
%% @version 0.1

-module(powers_tail).
-export([raise/2]).

-spec(raise(number(), number()) -> number()).
raise(_, 0) ->
	1;
raise(X, N) when N < 0 ->
	1 / raise(X, -N);
raise(X, N) when N > 0 ->
	raise(X, N, 1).

-spec(raise(number(), number(), number()) -> number()).
raise(_, 0, A) ->
	A;
raise(X, N, A) ->
	raise(X, N - 1, X * A).
{% endcodeblock %}

For the last task, the author decided to up the difficulty a wee bit.  The new function in the powers module, is to find the nth root by guessing (<a href="http://en.wikipedia.org/wiki/Newton%27s_method" target="_blank">Newton-Raphson</a> method for calculating roots).  Another addition is the outputting of the guesses while the function is working.  I was excited to work on this problem, since it was the first one to really use everything that we have learned so far: functions, Variables, if statements, and recursion.

{% codeblock lang:erlang %}

...

-spec(nth_root(number(), number()) -> number()).
nth_root(X, N) ->
	nth_root(X, N , X / 2.0).

-spec(nth_root(number(), number(), number()) -> number()).
nth_root(X, N, A) ->
	io:format("Current guess is ~p~n", [A]),
	F = raise(A, N) - X,
	Fprime = N * raise(A, N-1),
	Next = A - F / Fprime,
	Change = abs(Next - A),
	if Change =< 1.0e-8 -> Next;
	   Change > 1.0e-8 -> nth_root(X, N, Next)
    end.
{% endcodeblock %}

Hope to see you tomorrow at the meetup!  Til next week, play some Frisbee Golf!