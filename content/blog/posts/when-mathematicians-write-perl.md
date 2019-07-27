---
type: post
title: "When Mathematicians Write Perl"
date: 2014-06-02 20:30:57 -0400
comments: true
categories: programming signal work
---
As a followup (of sorts) to [my last post](http://someguyontheinter.net/blog/an-entirely-needless-obstruction/), I give you the following:

```perl
sub Derivative1 {
    my ($x,$y)=@_;
    my @y2;
    my $n=$#{$x};
    $y2[0]=($y->[1]-$y->[0])/($x->[1]-$x->[0]);
    $y2[$n]=($y->[$n]-$y->[$n-1])/($x->[$n]-$x->[$n-1]);
    my $i;
    for($i=1; $i<$n; $i++) {
	$y2[$i]=($y->[$i+1]-$y->[$i-1])/($x->[$i+1]-$x->[$i-1]);
    }
    return @y2;
}
```

That code is correct, right?  I sure hope so, because man do I not want to grovel over that and figure out what the hell it is doing.

This glorious manifestation of the human intellect comes from [Math::Derivative](http://search.cpan.org/dist/Math-Derivative), a Perl module which, well, does what it says on the tin: it provides functions that compute first and second derivatives of matrices of points.  The excerpt above is the first derivative function; the second derivative function is just like that, except more so.

To start out I should mention that it consistently provides plausible results (I'm using it in code that tries to detect sudden changes in rate of change of numeric metrics over time, _i.e._ "call for help if the database starts bloating up"), but the style, oh, where to start?

* Um, whitespace?  Ever?  Between lines?  Between characters?  It's like reading someone's JavaScript after it's been through [JSMin](http://www.crockford.com/javascript/jsmin.html) or some such.  Especially since Perl is tolerant of inserting newlines for clarity, there's no excuse.
* The variable names.  Yes, I know, it's basically translating from the formula, but the combination of the one-character names with the one-character (or multi-character) sigils - seriously, `$n=$#{$x}`, I never want to see you again - is a recipe for headache.  Oh, and also you have to play detective to figure out what kind of data each variable represents?  Was it immediately obvious to you that the `$x`{:lang="perl"} and `$y`{:lang="perl"} that get passed into the subroutine are references to arrays of scalar values?  Yeah, it's clear in retrospect, but the [principle of least astonishment](https://en.wikipedia.org/wiki/Principle_of_least_astonishment) is not just for user interfaces.
* The mishmash of operators.  Considering the previous two points, the similarity between the `-` operator (in this case numerical subtraction) and the `->` operator (dereference) and the `>` operator (numerical greater-than) makes the code look eerily like a [QR code](https://en.wikipedia.org/wiki/Qr_code) or a [random-dot stereogram](https://en.wikipedia.org/wiki/Random-dot_stereogram).

And so forth.  There's no good reason why this code has to be so obscure; sure, it's written in an older idiom, but even then it was terrible.  One thing at least the author can be proud of: the version of this module on CPAN is 0.01, written in 1995.

Apparently mathematicians get it right the first time. :)
