---
layout: post
title: "Études for Erlang - CH 5"
date: 2013-07-15 23:36
comments: true
categories: [erlang]
---
Have you missed me??  For the past two weeks I have been driving to and from many a wedding.  My cousin, Olivia, got married two weeks ago to an awesome man, John!  Then this past weekend my best friend growing up, Ben, got married to a lady who I do not know to well but any person he would marry must be a great gal!  To each of you I wish you the best!

I am going to still only do one chapter per blog post, so hopefully you should see two more posts right after this one!  For those of you who have forgotten completely what I have been talking about for the past 6 weeks check out [chapter 4](/2013/06/25/etudes-for-erlang-ch-4/).

Let's hop right into the good stuff!

## Chapter 5: Strings
[link](http://chimera.labs.oreilly.com/books/1234000000726/ch05.html)

During the meetup, everyone discussed the first etude in the chapter as really really annoying!  The task set before us is to go against erlang, and create a command line front end to our area functions that does not fail but gives pretty error messages.  While I do agree this exercise sucks, it was still pretty interesting to try and do something really easy in another language only to find it super hard in erlang.

The exersise asks us to create our command line util in a module named ask_area, with a function called area.

{% include_code erlang-etudes/ch5/ask_area.erl %}