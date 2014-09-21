---
layout: post
title: "Études for Erlang - CH 9"
date: 2013-07-28 13:02
comments: true
categories: [erlang,series]
---
Welcome back, my fellow Erlangers!!  After last weeks etude about [processess](/2013/07/22/etudes-for-erlang-ch-8/), let's just say I am super excited to get started on chapter 9 this week.  I mean who could not be excited.  Not only did we all get to relive a small part of our childhood, but we also got into the MEAT of Erlang.  It was also the first time that as a programmer you could really show your personallity within your code.  Prior to chapter 8, each little detail was spelled out for how to do every execise leaving little to the imagination.

What this led to in the [Meetup](http://www.meetup.com/Erlang-NYC/) atleast, was a bunch of code that all looked exactly the same.  For chapter 8's show and tell, each developer who showed their solution had a slightly different way of doing it.  There were the ones who did exactly like the book's solution, all in one module and straight to the point.  Then there were a few of us, like myself, who broke the problem down across a few modules and many functions within each module to better describe the problem with code.

Alright time to get started working on this weeks problems, Ready, Set, GOOOOO!!!<!-- more -->

## Chapter 9: Handling Errors
[link](http://chimera.labs.oreilly.com/books/1234000000726/ch09.html)

What the hell!?!? We went from full on awesome, to error handling.  This book is like riding a roller coaster where for the first bit you have to slowly and noisily climb up the a hill.  Then you finally get to the top and start heading down what you think is the hill of awesome, only to find you just went down a measly 30 foot drop only to ride parallel to the ground going straight not even a banked turn.

Oh well, lets move on.  The first exercise is to add some try catch blocks to our stats module that has been following us around for the past 3 weeks.  The idea is to return a touple like: <code>{error, atom()}</code> if one of the math functions does not like what we give it.

{% include_code lang:erlang erlang-etudes/ch9/stats.erl %}

Nothing there was too different from any other programming language, in terms of syntax.  The only thing that might get you caught up is <code>error:Error</code> syntax for binding the error to a variable.

Ok, things are starting to look up for this etude, we get to simulate a bank.  The main principle that we are trying to learn is, logging in Erlang.  

As a side note I want to mention, I am always suprised by what just comes standard with Erlang.  Most languages do not have logging modules built into them.  Erlang even comes with a testing framework EUnit, which I will actually use today to make this a little bit more engaging.

Back to building a bank.  For our bank we want our customer (the console) to be able to specify how much money they want to start with. AWESOME!  Wish that was real life… Given that amount as a starting point, let the customer either: deposit money, withdraw money, see their balance, or finish their session.

As I noted our customer will be the console, which sucks!  The book says to use our code to prompt the user from [chapter 5](/2013/07/08/etudes-for-erlang-ch-5).  I however hated how much coding that required me to do, and I only had a solution for just that specific prompt.  So I went ahead and created a UI module to put that code into a seporate more abstract form.

{% include_code lang:erlang erlang-etudes/ch9/ui.erl %}

I created a simple way to ask for a number, ui:request_number/1, where all that is needed is the prompt string.  I also needed to be able to prompt the user for a selection from a list of options. For that I added ui:request_action/1, where the developer can pass in a list of touples: <code>{LowerCaseChar, PromptString, Atom_Representing_Action}</code>.  For each touple passed in, the code will create a full prompt string and return the selected action in the form of the passed in, Atom_Representing_Action.  I also tried to seporate out the logic from the console input, so that I could test the building of the strings and action selection.

Now that I do not have to duplicate more ui request code, I will get started on the bank module.  The author gives us 3 requirements that must be met and logged.

1. Deposits and withdrawals cannot be negative numbers (logged as error)
2. Deposits of $10,000 or more might be subject to hold (logged as warning)
3. All other transactions are successful (logged as informational)

There are a few things I want to mention before you look at the code.  I again tried to break out the connection between the console input from the logic, so that I could test the logic functions.  I did this by allowing some functions to accept a <code>fun</code> parameter that can be swapped out in the tests to not use the console for input.  I also broke each seporate type of transaction into their own function sets to better contain their logic and test-ability.

{% include_code lang:erlang erlang-etudes/ch9/bank.erl %}

While at first I realize I was not as excited about the chapter as I was before I read the title, but in the end it turned out to be a fun one.  Due the the simplicity of what the book asked me to do, I was able to better write my code to test it without reliance on the console.

If you have any suggestions about how I could improve the tesability or readability of the code, I would love to hear them.  Since I am still learning Erlang I might have done things that a veteran Erlang programmer would never do, so please let me know.  Also if you have a solution you want to share, just put a link to your solution in the comments, I will take a look.

Til next week, Bon Voyage!!!  Oh come to the [Meetup](http://www.meetup.com/Erlang-NYC/)!