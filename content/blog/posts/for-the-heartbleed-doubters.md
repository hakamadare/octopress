---
layout: post
title: "For the Heartbleed Doubters"
date: 2014-04-13 11:33:08 -0400
comments: true
categories: signal security sysadmin
---
I promise that this is not going to become the All Heartbleed All The Time blog, but in my defence, this is [kind of a big deal](http://blog.jcuff.net/2011/12/cautionary-tale-about-storage-and.html).

A vendor called [CloudFlare](https://www.cloudflare.com/overview) decided to perform a practical test of the exploitability of Heartbleed by setting up a vulnerable site and [challenging people to steal the private key](http://blog.cloudflare.com/answering-the-critical-question-can-you-get-private-ssl-keys-using-heartbleed).  I think these two quotes encapsulate the story perfectly:

{% blockquote %}
Here’s the good news: after extensive testing on our software stack, we have been unable to successfully use Heartbleed on a vulnerable server to retrieve any private key data.
{% endblockquote %}

followed by:

{% blockquote %}
It turns out we were wrong. While it takes effort, it is possible to extract private SSL keys. The challenge was solved by Software Engineer Fedor Indutny and Ilkka Mattila at NCSC-FL roughly 9 hours after the challenge was first published.
{% endblockquote %}

Now consider a tool that [my buddy Ventz put together](http://blog.vpetkov.net/2014/04/11/ridiculously-fast-heartbleed-subnet-scanner-nmap-heartbleed-howto-and-tutorial/) for bulk scanning of network segments to detect Heartbleed-vulnerable webservers.  There's no reason to believe that he was the first person to think of building something like this.

The two lessons I see here are the following:

1. Remember that there's a difference between "I can't do it" and "It's impossible" :)  Smart people tend to forget this, to their and others' detriment.

2. There is no more [security through obscurity](https://en.wikipedia.org/wiki/Security_through_obscurity).  If your service is accessible from the public Internet, you should assume that you are being scanned on a regular basis.

-steve
