---
layout: post
title: "Études for Erlang - CH 8"
date: 2013-07-22 23:14
comments: true
categories: [erlang]
---
For the past few weeks we have been diving into the normal workings of Erlang.  So far however we have not really ran into anything that makes Erlang special.  To be honest if what we have gone over so far is all that was to Erlang, I would probably tell you to never use this language ever, ever, ever.  Ok maybe that is a little over the top, but as you saw in [Chapter 5](/2013/07/08/etudes-for-erlang-ch-5/) Erlang does not handle strings very nicely and that is a lot of what a I use in my day to day programming.

BUT FEAR NOT, my fellow compatriots, there is way more to Erlang.  Today, in this etude we will enter the bread and butter of Erlang.  Welcome my friends to Erlang [Processes](http://www.erlang.org/doc/reference_manual/processes.html)!!!! <!-- more -->

## Chapter 8: Processes
[link](http://chimera.labs.oreilly.com/books/1234000000726/ch08.html)

Last week in [Chapter 7](/2013/07/15/etudes-for-erlang-ch-7/) the etude concluded with an excersise that used list comprehension to create a deck of cards.  If I was a studied fortune teller, I might have told you that, that could be an ammonius sign pointing to this weeks etude.  I however am not and did not exactly point this out.

The lesson this week asks us to simulate a childhood card game used by parents to keep their kids occupied for hours and hours, The Game Of War (*Dun Dun Duuuuunnn*).  This game has some very simple rules:
	1. Split the deck evenly between two people
	2. Each turn consists of each player laying down a card
	3. Winner is person with the highest card (Aces high)
	4. If the cards match, each player lays down three and the last one is used to battle.
	5. This continues until one player has all the cards to the other player does not have enough cards to play a turn.

Alright, now I know what you are thinking, "Cool a card game, but what does that have to do with Erlang processes??"  Well I have an answer for that, think of cards as messages that are passed between people.  Then think about people as processes, catching the drift yet?

First on the agenda is to plan out how we want the code to work.  Since this will be the most complex piece of Erlang software we have written so far, it makes sense to spend a little time planning out the plan of attack.  I decided to use (Lucid Charts)[https://www.lucidchart.com/] to map out how I thought the flow of messages and the logic will progress.  

Here is a picture of what I came up with:

{% img /downloads/code/erlang-etudes/ch8/war-planning.png %}

I did not shy away from the author's suggestion to break it down into players and dealer.  After my planning session I took a little break to make sure I did not just rush out a solution.  This is what I came up with when I got to coding:

{% include_code lang:erlang erlang-etudes/ch8/deck.erl %}

{% include_code lang:erlang erlang-etudes/ch8/player.erl %}

{% include_code lang:erlang erlang-etudes/ch8/dealer.erl %}

I wanted to be able to easily test with a smaller sized deck, like the etude suggested.  I created a war module that takes in the size of the deck and starts up the game.

{% include_code lang:erlang erlang-etudes/ch8/war.erl %}

Here is an actual game that my simulation outputs:

{% include_code lang:erlang erlang-etudes/ch8/output.txt %}

If you want to see a different and probably better solution check out the solution in the book: [Game.erl](http://chimera.labs.oreilly.com/books/1234000000726/apa.html#_literal_game_erl_literal)

