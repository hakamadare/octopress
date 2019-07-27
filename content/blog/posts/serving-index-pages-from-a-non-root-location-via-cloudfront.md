---
type: post
title: "Serving index pages from a non-root location via CloudFront"
date: 2015-01-12 13:22:36 -0500
comments: true
categories: work sysadmin signal tools
---
As a change of pace from my [last post]({% post_url 2015-01-01-losing-weight %}), I now present you with a wonky AWS issue, created mostly by departing from Amazon's standard pattern of S3 static site hosting; hopefully this will be useful to someone else in a similar position.

So, as you may be aware, you can use AWS S3 to [host a static website](http://docs.aws.amazon.com/AmazonS3/latest/dev/WebsiteHosting.html).  Furthermore, once you've done so it's not difficult to use AWS CloudFront (the content distribution network service) to serve out your site; the CloudFront workflow is clearly set up for you to put CloudFront in front of a S3-hosted website (such as [this blog]({% post_url 2014-03-30-hello-world %})!).

As long as your site is laid out something like the following, you'll be in good shape:

```console
/
/index.html
/images/
/images/foo.png
/images/bar.png
...
```

However, you can run into odd behavior if your site contains paths like this:

```console
...
/some_subdirectory/index.html
...
```

and you want to be able to browse to `http://your-site.tld/some_subdirectory/` and have the server automatically serve out the index page.  Since S3 doesn't really have a notion of a directory hierarchy, but rather has a flat structure of keys and values with lots of cleverness that enables it to simulate a hierarchical structure, your request to CloudFront gets converted into "hey S3, give me the object whose key is `some_subdirectory/`", to which S3 correctly replies "there is no such object".

When you enable S3's static website hosting mode, however, some additional transformations are performed on inbound requests; these transformations include the ability to translate requests for a "directory" to requests for the default index page inside that "directory" (which is what you want), and this is the key to the solution.  In brief: when setting up your CloudFront distribution, don't set the origin to the name of the S3 bucket; instead, set the origin to the static website endpoint that corresponds to that S3 bucket.

Huh?  Ok, here's an example:

<!--more-->

1. Create a S3 bucket called `your-site.tld`.
2. Upload your site to that bucket.
3. Make the uploaded content world-readable (_e.g._ by applying a bucket policy like the one documented as "[Granting Read-Only Permission to an Anonymous User](http://docs.aws.amazon.com/AmazonS3/latest/dev/example-bucket-policies.html)").
4. Enable static website hosting for the bucket.  Make note of the static website endpoint; it'll look something like `your-site.tld.s3-website-us-east-1.amazonaws.com` (perhaps in a different AWS region).
5. Configure an appropriate index document when enabling static website hosting (the default value is `index.html`).
6. Verify that you can browse to the static website endpoint and that your site renders correctly.  In particular, make sure you test the `some_subdirectory/` behavior.  If this isn't working now, **STOP**, go back, and debug; if this part doesn't work, none of the rest will help you.
7. CloudWatch time!  Create a new CloudWatch web distribution.
8. When creating the CloudWatch distribution, set the origin hostname to the static website endpoint (you made note of this back in step 4).  Do **NOT** let the AWS console autocomplete a S3 bucket name for you, and do not follow the instructions that say "For example, for an Amazon S3 bucket, type the name in the format bucketname.s3.amazonaws.com.".
9. Also, do not configure a default root object for the CloudFront distribution.  All of that magic will be handled by S3, and adding additional magic at the CloudFront layer will only confuse things.
10. Configure the desired hostname for your site (_e.g._ `your-site.tld`) as an alternate domain name for the CloudFront distribution.
11. Finish creating the CloudFront distribution; you'll know you've done it correctly if the Origin Type of the origin is listed as "Custom Origin", not "S3 Origin".
12. While the CloudFront distribution is deploying, set up the necessary DNS entries in Route 53 (if you're using a different DNS provider, then you'll be stuck with some sort of CNAME shenanigans; consider switching to Route 53).  Create an A record (and an AAAA record if you want to support IPv6) as a Route 53 alias to your newly created CloudFront distribution (it should appear as an autocompletion option in the alias field).

At this point you should be all set!  Once your distribution is fully deployed and the A record has propagated, browse around in your site; you should see all of your content, and it'll be served out via CloudFront.  Essentially what you are doing is using CloudFront as a simple caching reverse proxy, and all of the request routing logic is being implemented at S3, so you get the best of both worlds.

**Note**: nothing comes without a cost, and in this case the cost is that you must make all of your content visible to the public Internet, which means that it will be possible for others to bypass the CDN and pull content directly from S3, and also that you need to make sure that you don't put anything in the S3 bucket that you don't want to publish.  If you need to use the feature of CloudFront that enables you to leave your S3 bucket with restricted access, using CloudFront as the only point of entry, then this method will not work for you.
