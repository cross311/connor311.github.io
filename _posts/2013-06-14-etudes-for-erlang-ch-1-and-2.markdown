---
layout: post
title: "Études for Erlang – CH 1 &amp; 2"
date: 2013-06-14 22:41
comments: true
categories: [erlang,series]
---
Have you ever thought to yourself, "What can I do with all my spare time" or maybe "There are all these people at work, that I really would like to get to know better"?  No, *really*, oh well I have.  The game plan I came up with was simple, find something that was related to work but happened after work and beer was provided.  The answer to all the worlds problems is <a href="http://www.erlang.org/" target="_blank">Erlang</a>, dun dun duda....  Ok maybe not, but the newly re-minted <a href="http://www.meetup.com/Erlang-NYC/" target="_blank">Erlang-NYC</a> meetup group was the answer to my problems.  For those of you who have never heard of this "<a href="http://www.meetup.com" target="_blank">Meetup</a>" idea, it is a group of people getting together to talk or act on a unified topic or activity.  This meetup's unified topic is Erlang, DUH, and they get together about once a month or more.<!--more-->

One of the series the group is doing follows along with a beginners guide to Erlang called, <a href="http://chimera.labs.oreilly.com/books/1234000000726" target="_blank">Études for Erlang</a>.  Every week we meet to go through one of the chapters from the guide and hopefully we all become more familiar with the language, while making friends with people of similar interests.  This week (06/10/2013) we had our first meeting to go through chapters 1 and 2.  Here are my solutions:
## Chapter 1: Getting Comfortable with Erlang

<a href="http://chimera.labs.oreilly.com/books/1234000000726/ch01.html" target="_blank">link</a>

Try leaving out parentheses in arithmetic expressions:

{% highlight erlang %}
(1+1.
syntax error before: '.'
{% endhighlight %}

Try adding <code>"adam"</code> to <code>12</code>:

{% highlight erlang %}
"adam" + 12.

** exception error: an error occurred when evaluating an arithmetic expression
 in operator +/2
 called as "adam" + 12
{% endhighlight %}

Make up variable names that you are sure Erlang wouldn’t ever accept

{% highlight erlang %}
VarNameWithAmp& = 1.
* 1: syntax error before: '&'

VarNameWithUnderScore_Test = 12.
12

atom_trying_to_be_var = 2.
** exception error: no match of right hand side value 2
{% endhighlight %}
<h2>Chapter 2: Functions and Modules</h2>
<a href="http://chimera.labs.oreilly.com/books/1234000000726/ch02.html" target="_blank">link</a>

Write a module with a function that takes the length and width of a rectangle and returns (yields) its area. Name the module <code>geom</code>, and name the function <code>area</code>. The function has arity 2, because it needs two pieces of information to make the calculation. In Erlang-speak: write function <code>area/2</code>.

{% highlight erlang %}
%% @author C J Ross <connor311@gmail.com>
%% @doc Functions for calculating areas of geometric shapes.
%% @copyright 2013 C J Ross
%% @version 0.1

-module(geom).
-export([area/2]).

%% @doc Calculates the area of a rectangle, given the
%% length and width. Returns the product
%% of its arguments.

-spec(area(number(),number()) -> number()).
area(Height, Width) ->
	Height * Width.
{% endhighlight %}

Test:

{% highlight erlang %}
2> c(geom).
{ok,geom}
3> geom:area(3,4).
12
4> geom:area(12,7).
84
5>
{% endhighlight %}

Generated EDoc:

<a href="http://connorjross.com/blog/wp-content/uploads/2013/06/Screen-Shot-2013-06-13-at-11.09.49-PM.png"><img class="aligncenter size-full wp-image-201" alt="Edoc - Geom" src="http://connorjross.com/blog/wp-content/uploads/2013/06/Screen-Shot-2013-06-13-at-11.09.49-PM.png" /></a>

Looking forward to next week!  Hope you can join myself and other <a href="http://www.mdsol.com" target="_blank">Medidatations</a> at the <a href="http://www.meetup.com/Erlang-NYC/events/122174852/" target="_blank">06/18/2013 Erlang-NYC Meetup</a>.

[Chapter 3]({% post_url 2013-06-16-etudes-for-erlang-ch-3 %})