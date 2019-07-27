---
type: post
title: "Octopress, S3, and file exclusion"
date: 2014-04-03 21:49:10 -0400
comments: true
categories: tools
---
OK, one more quick thing:

I knew from the get-go that I wanted to host this blog on [S3](https://aws.amazon.com/s3/), and that I wanted to build it with [Octopress](http://octopress.org/).  One relatively minor conflict between these two tools, though, is that S3 buckets work well for hosting static sites, but Octopress is built on top of Git, and I was sure I didn't want to be uploading my Git metadata to S3.

[s3_website](https://github.com/laurilehmijoki/s3_website) is the tool I'm using to push my generated site to S3.  It has a config option, `exclude_from_upload`, which enables you to specify one or more regexes to match files to be excluded from S3 uploads.

> [Some people, when confronted with a problem, think "I know, I'll use regular expressions." Now they have two problems](http://www.jwz.org/hacks).

Yeah, it turns out that putting the string `.git` in my excludes list (instead of `\.git`) broke a variety of things on the site, including but not limited to the following:

* my GitHub status in the sidebar
* a post with "GitHub" in the title
* Disqus comment counts

So yeah, don't do that.
