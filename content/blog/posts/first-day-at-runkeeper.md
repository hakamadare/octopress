---
type: post
title: "First day at RunKeeper"
date: 2014-04-01 22:57:14 -0400
comments: true
categories: work signal
---
I'm winding down at the end of my first day at [RunKeeper](http://runkeeper.com), and I'm still walking on air :)  Today started with me apparently being a bit jittery while shaving this morning:

{% img center /images/shaving_cuts.jpg 240 320 "ouch" %}

and ended with me running (while wearing [clogs](http://www.amazon.com/Sanita-457806M-20-Professional-Cabrio-Clog/dp/B001CWYZME), ow) to North Station to catch the commuter rail, and today was STILL awesome.

It's really good to work with my old boss Matt again, and I'm really liking the generally happy atmosphere, and the tiny dog wandering around the office, and I've already come up with some tasks I want to try to get my arms around in the near future.  Plus I didn't break anything on the first day!

I spent a chunk of the past week building my new laptop by means of [Boxen](https://boxen.github.com), and I really like this approach to workstation management.  A lot of the work I've been doing during the past few years focuses on server and application automation, and as a result my servers tend to be (relatively) neat and well-ordered while my laptop is a wretched hive of scum and villainy; if I recall correctly, the laptop that I handed in last week contained the fifth generation of a lovingly hand-crafted workstation configuration, which started out as a Mac OS X 10.2 installation on a PowerPC Mac laptop and underwent multiple ordeals of Migration Assistant/Carbon Copy Cloner/etc. to attain its final Mac OS X 10.7 on Intel status, accumulating tons of cruft as it went.

So now my workstation config lives in a GitHub repository, and deploying it onto a new machine is remarkably straightforward.  I have about 70% of what I need captured in code; now I just need to be reasonably diligent about keeping up with changes I make post-installation, and next time around I will be much happier.

Current ruling on Boxen:

Pro:

* configuration captured in code
* safe to re-apply config repeatedly
* upstream maintainers quite responsive to pull requests

Con:

* no simple way to handle apps that require post-installation configuration (maybe capture `.plist` files in the repo as templates? yuck)
* _really_ does not play nicely with multiple local users on the same host (I may have to end up abandoning my habit of maintaining one user account for work and one for personal use, and leveraging [ControlPlane](http://www.controlplaneapp.com) to compensate)

-steve

P.S. Oh right, I had also stumbled belatedly onto this Garamond silliness via [this excellent refutation](http://www.thomasphinney.com/2014/03/saving-400m-font/).  My only contribution to the debate, such as it is, is to suggest that Garamond is weaksauce and that real toner-savers use [Ecofont](http://ecofont.com/).
