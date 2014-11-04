---
layout: post
title: "Design Patterns: Circuit Breaker"
date: 2014-11-4 05:41
comments: true
tags: [design_pattern,coding,csharp]
---

I have been working with a skilled software architect for the past couple of months.  Learning the fact that being a software architect is not all about designing the most beautiful, cutting edge system I could think of.
The main point, to me has been, that I need to know the physics of what is actually possible for a given software project and team.
If a design would take years to build or the current team does not have the expertise to build the components, the beauty of the design does not matter because it will never see the light of day.
To help grow my knowledge as to what is possible and what is not, I am going to code up some design patterns that have interested me for a long while.

What got me into this design pattern adventure was stumbling accross a great collection of articles from [Microsoft](http://msdn.microsoft.com/en-us/library/dn600223.aspx).  I would recommend looking through the list, most of them have examples.

### What is a Circuit Breaker

When an external resource starts to fail, it might take a long time for it to come back online.
If the failure results in a timeout exception, the software it might be holding onto threads, memory,
and an assortment of other in demand items while it is waiting to timeout.
A circuit breaker keeps track of the failures so that once a threshold is reached it stops calling the resource and instead trips the breaker.
While the breaker is tripped any calls to the resource will imediatly return as a failure due to the circuit being tripped.
Having the knowledge that the circuit is tripped can allow the application to look elsewhere for the results, maybe a cache or a subset of the resource information.
After a given amount of time the circuit breaker will let a call through to the resource to see if the resource is back online.
If the resource responds successfully the breaker closes the circuit and all returns to normal.
However if the resource is still down the circuit will stay tripped and attempt to try again at a later time.

### Why Would I Use A Circuit Breaker?

In today's distributed cloud micro service oriented mombo jumbo, you might find yourself creating an application that has many upstream dependancies.
Say you were working at [Twitter](https://twitter.com/otter311) and to show a tweet you would have to pull in the user information, a picture, a geolocation, and the tweets retweeted / favorited counts.
Each of those dependancies are managed by a different service that requires a network call, but if anyone of those services is down the showing of a tweet not error.
Let's say the geolocation service is having a major delay causing a timeout exception on your end that could add 30 seconds+ to each of the requests for a tweet times 50 per page, you are looking at a major slow down.

If the call to the geolocation service was on a circuit breaker, then when it timedout a few times the circuit would trip.
Because geolocation is not a primary feature the tweet can just not show that information.  With the circuit tripped the application gets instant feedback that the
information is not available, not 30+ second delays.

The other advantage is also for the geolocation service.  If the geolocation service was having crazy load that it could not keep up with, having requesters stop berating it with calls would allow it to catch up or time to spin up another instance.
Each requester will also not start full traffic patterns all at the sametime because of the wait to check if the service is back online.

### The Code

The [article](http://msdn.microsoft.com/en-us/library/dn589784.aspx) I read from Microsoft, stated that there might be a number of different strategies for determining when to trip the circuit or when to half open.
I wanted to write something that captured the main concept, but allowed developers to inject the proper trip / half open strategy for their specific use case.
I followed the code from the article almost to the T, except I created two interfaces that encapsulated the logic for when to switch from closed to open and visa versa.

Closed To Open: [interface](https://github.com/cross311/circuit-breaker-csharp/blob/master/src/ICircuitBreakerClosedToOpenStateTransition.cs), [fail count implementation](https://github.com/cross311/circuit-breaker-csharp/blob/master/src/FailCountBasedCircuitBreakerClosedToOpenStateTransition.cs)


{% gist cross311/b973f8659d3094e3ec0d ClosedToOpenStateTransition.cs %}


Open To Closed: [interface](https://github.com/cross311/circuit-breaker-csharp/blob/master/src/ICircuitBreakerOpenToClosedStateTransition.cs), [wait time implementation](https://github.com/cross311/circuit-breaker-csharp/blob/master/src/WaitTimeBasedCircuitBreakerOpenToClosedStateTransition.cs)


{% gist cross311/b973f8659d3094e3ec0d OpenToClosedStateTransition.cs %}


Given those two interfaces the circuit breaker class can concentrate on managing the state transitions and the complicated exception logic.

The closed to open transition hooks are on lines `85` and `105`.  Allowing tracking of failure and success while the circuit is closed.  I also passed in the exception
so that if a specific exception might warrent going straight to open even on the first throw the implementer could do that.

The open to closed transition hook is on line `76`.  The key to determining when to return to closed state is how frequent allow a request to try again, this state is called half open.  So the hook is given the information about the current state and historical state of the circuit to determine if another request should be attempted.


{% gist cross311/b973f8659d3094e3ec0d circuitbreaker.cs %}

### Future Plans

I have pushed the code that I created for this post up to github at [https://github.com/cross311/circuit-breaker-csharp](https://github.com/cross311/circuit-breaker-csharp).  Feel free to open pull requests against it!!  I plan on trying to make a nuget package, so that I might be able to use it in a production application at work (I will report back if I get it in!).

Until the next design pattern post, Stay Classy!

### Further Reading

 - [Microsoft on design patterns](http://msdn.microsoft.com/en-us/library/dn600223.aspx)
 - [Netflix's blog about circuit breakers](http://techblog.netflix.com/2011/12/making-netflix-api-more-resilient.html)