---
type: post
title: "Bundler 1.10.x and Warbler 1.4.7 are NOT friends"
date: 2015-06-01 14:52:57 -0400
comments: true
categories: sysadmin work
---
On the off chance that you are deploying Ruby apps as Java Servlets using [JRuby](http://jruby.org/)/[Warbler](https://github.com/jruby/warbler), beware of recent releases of [Bundler](http://bundler.io).  Bundler 1.10.0 came out this past Sunday (May 28, it looks like), and it [doesn't play nicely](https://github.com/bundler/bundler/issues/3691) with Warbler.

The failure happens when you first use Bundler >= 1.10 to build a dependency tree prior to running `warble`, whereupon `warble` blows up with a distinctive error message like `ArgumentError: dependency name must be a String, was #<Bundler::StubSpecification:0x1e69dff6`.

I'm a bit perplexed by [@indirect](https://github.com/indirect)'s comment on the issue linked above that "Bundler's internal Ruby APIs are not stable and may change"; sure, but this seems to me like the kind of change that [merits a major version bump](http://semver.org).  If a method on an object used to return a `String`, and now it returns a `Bundler::StubSpecification`, that's not an insignificant change!  At least perhaps include a `to_s` method that spits out the string that would previously have been returned?

I dunno, maybe there's a policy doc somewhere on the Bundler site which defines what the internal Ruby APIs are that one should assume will change at any moment; I searched a bit and couldn't find one, but I apologize in advance if the failure is in my searching.
