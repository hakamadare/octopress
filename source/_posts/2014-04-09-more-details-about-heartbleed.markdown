---
layout: post
title: "More Details About Heartbleed"
date: 2014-04-09 22:39:30 -0400
comments: true
categories: signal sysadmin
---
If you haven't yet [patched your OpenSSL and regenerated your certs](http://heartbleed.com), stop reading and go fix it; it's OK, I'll still be here when you get back.

All set?  OK.  I found an interesting analysis of the bug over at [this guy Sean Cassidy's blog](http://blog.existentialize.com/diagnosis-of-the-openssl-heartbleed-bug.html).  In brief: I have been happy for many years that other people like to write C, because it means both that I get to benefit from their work (basically my entire livelihood is based on the C ecosystem) and also that I generally don't have to write it myself. :)

<!-- more -->

In other news, I think I accumulated my first piece of [technical debt](http://martinfowler.com/bliki/TechnicalDebt.html) at the new job today.  I spent a while fighting with [signed apt packages](http://blog.jonliv.es/2011/04/26/creating-your-own-signed-apt-repository-and-debian-packages/); by the time I headed home I had managed to unbreak the repository, but I still have one Java package with an invalid signature, so tomorrow I'll go another few rounds.
