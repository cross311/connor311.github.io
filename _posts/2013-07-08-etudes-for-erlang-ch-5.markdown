---
layout: post
title: "Études for Erlang - CH 5"
date: 2013-07-08 23:36
comments: true
categories: [erlang,series]
---
Have you missed me??  For the past two weeks I have been driving to and from many a wedding.  My cousin, Olivia, got married two weeks ago to an awesome man, John!  Then this past weekend my best friend growing up, Ben, got married to a lady who I do not know to well but any person he would marry must be a great gal!  To each of you I wish you the best!

I am going to stick to doing only do one chapter per blog post.  Hopefully you should see two more posts right after this one!  For those of you who have forgotten completely what I have been talking about for the past 6 weeks check out [chapter 4]({% post_url 2013-06-25-etudes-for-erlang-ch-4 %}).

Let's hop right into the good stuff!<!--more-->

## Chapter 5: Strings
[link](http://chimera.labs.oreilly.com/books/1234000000726/ch05.html)

During the meetup, everyone discussed the first etude in this chapter as really really annoying!  The task set before us is to go against the erlang mantra of "let it fail", and create a command line front end to our area functions that does not fail but gives pretty error messages.  While I do agree this exercise sucks, it was still pretty interesting to try and do something that is really easy in another language only to find it super hard in erlang.

The exersise asks us to create our command line util in a module named ask_area, with a function called area.

{% gist cross311/f10d702e56d6bc80b546 ask_area.erl %}

Alright if any of you worked through that with me, how long did it take you to get the right pretty error messages???  That was intense, even my stand by to just output what the code is returning to me does not work well in erlang.  I have to guess correctly as to what kind of type the thing I am trying to <code>io:format("~X~Y~Z…")</code>, else the whole thing blows up with an invalid arguments exception.

After that exercise I think even the author was done but his editor told him he needed two exercises in this etude.  I think that because the second exercise is kinda a joke compared to the first.  All that is needed is to take  ISO date formated string "yyyy-mm-dd" and return [yyyy,mm,dd] with ZERO error handling. Easy enough right.

{% gist cross311/f10d702e56d6bc80b546 dates.erl %}

Thats it. If anyone asks me to write a command line utility again in erlang, I am going to tell them that I will buy them lunch if I can write it in another language like ruby or c#.

Let me know if you ran into any other interesting issues while working on this weeks etudes!

[MEETUP](http://www.meetup.com/Erlang-NYC/)

[Chapter 7]({% post_url 2013-07-15-etudes-for-erlang-ch-7 %})