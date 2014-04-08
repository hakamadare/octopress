---
layout: post
title: "PEM Files, for the Last Damn Time"
date: 2014-04-07 20:49:22 -0400
comments: true
categories: signal ssl drinks
---
OK, I am tired of forgetting this information and having to re-research it.

A [PEM file](https://en.wikipedia.org/wiki/.pem#Certificate_filename_extensions) is an X.509 digital certificate, specifically a "Base64 encoded DER certificate" (thank you Wikipedia).  The components are concatenated in the following format:

1. Private key (optional)
2. Server certificate
3. Intermediate certificate (optional)
4. Root certificate (optional)

or, in other words, `cat server.key server.crt ca-bundle.crt >> server.pem`.

That is my final word on the subject.
<!-- more -->
This evening did not involve attending our intended [Peter Mulvey](http://petermulvey.com/) concert, but did involve hanging out at home with various friends and drinking a [Bourble](http://wiki.webtender.com/wiki/Bourbon_Triple_Sec_Lemon_Juice); I hadn't previously encountered this cocktail, but rather mixed it in an attempt to finish off a bottle of triple sec.  It wasn't bad; I found the lemon juice a bit too strong and will use less next time, or maybe lime juice, or maybe a [Meyer lemon](https://en.wikipedia.org/wiki/Meyer_lemon) if I have one handy.
