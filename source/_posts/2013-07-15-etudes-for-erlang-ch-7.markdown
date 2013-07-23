---
layout: post
title: "Études for Erlang - CH 7"
date: 2013-07-15 22:58
comments: true
categories: [erlang]
---
I have been working double duty tonight, since I have been slacking on my blogging duty.  I am again slacking, I am going to skip from [chapter 5](/2013/07/08/etudes-for-erlang-ch-5/) to chapter 6 for now. <!-- more -->

## Chapter 7: Higher Order Functions and List Comprehensions
[link](http://chimera.labs.oreilly.com/books/1234000000726/ch07.html)

This etude starts off freshman HS year style, with a little calculus!  It is asking us to create a method that determines the derivative of an anonymous function.

{% include_code lang:erlang erlang-etudes/ch7/calculus.erl %}

The next exercise is pushing our understanding of what we can do with [list comprehensions](http://www.erlang.org/doc/programming_examples/list_comprehensions.html).  It asks if it is possible to use pattern matching and list comprehension together?  I think YES.

{% include_code lang:erlang erlang-etudes/ch7/people.erl %}

I am starting to notice a pattern with this chapter, and I think it is lists.  Next we get to finally use some functions implemented by the framework, and not have to implement them ourselves.  The function that gets the privalige of our attention first is: lists:foldl/3. Don't exactly know why there is an l at the end, scratch that just looked it [up](http://www.erlang.org/doc/man/lists.html#foldr-3).  It seems as though you can pick which direction you want to fold the list up, which makes sense.

{% include_code lang:erlang erlang-etudes/ch7/stats.erl %}

More list work…

{% include_code lang:erlang erlang-etudes/ch7/list_test.erl %}

Have you been waiting for an exercise that kinda sorta had a real world feel to it?  Well prepare to have you real world socks, get barely dirty but still dirty!

We will now use what we have learned about list comprehension to create a deck of cards!  We also get to figure out how a pre-defined function works, then comment it. Junior Software Engineer in each of us just sighed a little, I know you did don't act like you were never assigned this task!

{% include_code lang:erlang erlang-etudes/ch7/deck.erl %}

Well I am excited to [Chapter 8](/2013/07/22/etudes-for-erlang-ch-8/), when we finally get into processes.  That is next week, so stay tuned!

What are you most excited to learn about processes, next week??

[Chapter 8](/2013/07/22/etudes-for-erlang-ch-8/)
[MEETUP](http://www.meetup.com/Erlang-NYC/)