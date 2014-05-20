---
layout: post
title: "A Real-Life Sysadmin Job Interview Question"
date: 2014-04-16 07:59:44 -0400
comments: true
categories: sysadmin signal
---
Yesterday one of my colleagues flags me down and points to his terminal.  "Hang on a second," he says as I walk over, "let me become root. <type type type> OK, watch this: see, there's plenty of free space on the root partition..."

At this point my heart leaps up with a sudden, fierce joy.  Could it be?  Really?

"But look, when I try to touch a file..."

```console
# df -h
OK, see this?  This is why people say uncharitable things about Perl:Filesystem            Size  Used Avail Use% Mounted on
/dev/xvde             7.9G  5.3G  2.3G  71% /
tmpfs                 828M     0  828M   0% /dev/shm
# cd /
# touch foo
touch: cannot touch 'foo': No space left on device
```

At this point I cannot keep the grin off my face.  "Try `df -ih`", I say.

```console
# df -ih
Filesystem           Inodes IUsed IFree IUse% Mounted on
/dev/xvde              512K  512K     0  100% /
tmpfs                  207K     1  207K    1% /dev/shm
```

Dun-dun-DUNNNNNNNNNNNNNN!

<!-- more -->

So, what's all this then?  My colleague had inadvertently presented me with a scenario that I have encountered in job interviews (on both sides of the table) throughout my career; I believe I was asked it when I first interviewed at [NDA](https://en.wikipedia.org/wiki/Net_Daemons_Associates), and I've been using it as a "weeder" question for years when screening junior admins.

To elaborate: my colleague was working on a system which appeared to have unused space on the root ("/") filesystem.  However, when he tried to create a new file in that filesystem, he received an unexpected and nonsensical error message; how could there be no space left on the device, when a moment ago he had seen that there were 2.3G available?

The answer has to do with [inodes](https://en.wikipedia.org/wiki/Inode).  An inode is, essentially, the address of a file in a Unix filesystem.  When a filesystem is created, a certain amount of space (the bulk of it) is allocated for storage of data, and a smaller amount is allocated for the storage of inodes.  Each file corresponds to one inode, and every file must have an associated inode.  (Yes, this is a [hand-wavy](http://www.catb.org/jargon/html/H/handwave.html) explanation; if you want more detail, go read the linked article :) )

The command my colleague initially ran, `df -h`, reports disk usage across all mounted filesystems (the `-h` makes the command output convenient, human-readable numbers like "5.3G" instead of "5525556").  However, when I asked him to add the `-i` argument, I was asking the command to report on inode usage rather than data usage; this quickly revealed that the root filesystem was out of inodes, and that was why my colleague couldn't create a new file.

Further investigation revealed that a misbehaving log aggregation utility was creating hundreds of thousands of files and failing to clean them up; time to go complain to the vendor.

-steve
