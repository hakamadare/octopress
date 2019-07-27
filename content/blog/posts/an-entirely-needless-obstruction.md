---
type: post
title: "An Entirely Needless Obstruction"
date: 2014-05-20 14:19:41 -0400
comments: true
categories: programming work signal
---
OK, see this?  This is why people say uncharitable things about Perl:

```perl
for (@cmd)
{
    next unless grep /^\Q$cmd\E$/, split(" ", $_->[1]);
    $cmd_data = $_;
    push @{$cmd_data->[3]}, ["filter", undef, undef, \&parse_filter] if $_->[1] =~ /\bdescribe/;
    for (@{$cmd_data->[3]})
    {
  for (split(" ", $_->[0]))
  {
      (my $key = $_) =~ s/-/_/g;
      $keyword{$key} = undef;
  }
    }
    last;
}
```

It doesn't matter whose code this is.  Suffice it to say that it

* is a crucial part of a publically-available, fairly popular program,
* was last edited in 2011,
* is standing in the way of my getting something accomplished today.

Where to even start?  What's with the magical anonymous array-indexed data structures?  The positional parameters (gotta pass those `undef`s or everything is busted)?  The assignment of named variables to `$_` (yay!) and then going on to dereference `$_` instead of the named variables?

I'm not sure I'm willing to give this a pass as being [baby Perl](http://www.modernperlbooks.com/mt/2009/03/turning-baby-perl-into-grownup-perl.html); this is just a design that has been stretched comically (tragically?) far beyond its original limits.  This makes me cranky and sad.

Time to figure out what the hell is going on here so that I can patch this code.  [Fantastic](http://www.modernperlbooks.com/mt/2011/01/cgi-is-okay-but-bad-code-is-irresponsible.html).
