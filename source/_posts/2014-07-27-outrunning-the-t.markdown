---
layout: post
title: "Outrunning the T"
date: 2014-07-27 09:53:07 -0400
comments: true
categories: sysadmin technology work
published: true
---
So, this past Friday [we](http://runkeeper.com) challenged the [MBTA](http://mbta.com) to a [road race](http://outrunthet.runkeeper.com).  This was a ton of fun; it was a gorgeous day, and the race ended with a come-from-behind victory.

There's [plenty](http://blog.runkeeper.com/2380/team-runkeeper-is-victorious-in-outrunthet-the-full-recap/) of [discussion](http://twitter.com/search?f=realtime&q=%23outrunthet) of the [public-facing](http://www.runnersworld.com/general-interest/runners-narrowly-win-race-against-boston-trolley) [aspects](http://www.boston.com/health/2014/07/25/yes-you-can-outrun-the-mbta-green-line/tO5A7tXXSgODU9QTKOI3ZI/story.html) of this event.  I'd like to tell you a bit about the technical work that made this event possible (spoiler alert: it involves loosely coupled systems).

<!-- more -->

# The Problem

One of the features we wanted to showcase in this event was [Live Tracking](http://runkeeper.com/what-is-elite#liveTrackingSectionAnchor).  Live Tracking is an Elite-only feature; essentially, you enable Live Tracking at the start of an activity, and you are assigned a custom URL for that activity that your friends can use to see your progress overlaid on a map, with real-time-esque updates (see [this help doc](http://support.runkeeper.com/hc/en-us/articles/201109836-How-to-enable-RunKeeper-Live) for more information).  During the race our runners would be live tracking, and in addition another team member would be live tracking while riding the trolley, so live tracking would be front and center in our presentation of the race; what's more, under normal circumstances a live tracking custom URL tracks only one user at a time, but during this event we would be tracking five users simultaneously in a single browser window.

This feature does impose some extra load on the application stack, however, and given that we had been vigorously promoting the event for several weeks prior, we foresaw (or at least really hoped) that we would be facing a significant traffic spike.  The question was, then, how to deliver a responsive, exciting race to all of the people glued to their browsers starting at 11AM EDT, while at the same time not affecting the user experience of all the rest of our users around the world.

## The Stack

At this point a brief overview of our application stack is probably in order.  The relevant application ([http://runkeeper.com](http://runkeeper.com)) lives on a cluster of beefy physical servers ([Tomcat](http://tomcat.apache.org/)), behind a cluster of load balancers ([HAproxy](http://www.haproxy.org/)), backed by a database ([PostgreSQL](http://www.postgresql.org/)) and cache ([Redis](http://redis.io/)).  We also use an external object store ([Amazon S3](http://aws.amazon.com/s3/)) and an external NoSQL DB ([Cloudant](http://cloudant.com/)).

{% img center /images/rkweb.png 449 384 "RunKeeper web stack" %}

This infrastructure stands up reasonably well to our normal production load; for example, here's a [NewRelic](http://newrelic.com/) graph showing requests per minute over the course of Friday, July 25.

{% img center /images/rkweb_throughput.png 456 203 "RunKeeper web throughput" %}

We have a pretty good idea of where the bottlenecks are in this architecture, and we know how to scale the individual components given enough time and resources, but rapidly scaling the entire stack in response to a traffic spike is a different story, so we started thinking about how to isolate the high-traffic area from everything else.

## The Application


