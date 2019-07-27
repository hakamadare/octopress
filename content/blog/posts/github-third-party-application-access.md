---
type: post
title: "GitHub Third-Party Application Access"
date: 2015-02-23 09:25:05 -0500
comments: true
categories: sysadmin security
---
[My buddy Phil](http://greptilian.com/) recently encountered an interesting example of unintended consequences by starting down the (initially nonthreatening) path of trying to integrate a third-party site with a GitHub organization.  It turns out the default access control configuration of a GitHub organization allows any member of the organization to grant third-party apps access to the data in that organization.

Go back and read that again.

Then read [Phil's writeup](http://crimsonfu.github.io/2015/02/22/owners-of-organizations-on-github-should-carefully-set-up-third-party-application-restrictions.html) for some more details.  This gives me plenty to think about.
