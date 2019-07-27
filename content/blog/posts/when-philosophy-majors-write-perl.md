---
type: post
title: "When Philosophy Majors Write Perl"
date: 2014-06-09 22:24:35 -0400
comments: true
categories: signal programming
---
In the interest of doing something other than [yelling at clouds](http://www.fanpop.com/clubs/the-simpsons/images/7414384/title/old-man-yells-cloud-photo), it occurred to me that rather than just [sniping](http://someguyontheinter.net/blog/when-mathematicians-write-perl/) at other people's Perl, I might step up and demonstrate an alternate path.  So, here goes; reference code is at [my convenience fork of Math::Derivative](https://github.com/hakamadare/Math-Derivative/tree/legible).

The original:

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

My substitute:

```perl
sub Derivative1 {
    my( $x_vector, $y_vector ) = @_;
    my( @derivatives );

    my $p1 = _getNextPoint( $x_vector, $y_vector );
    my $p2 = _getNextPoint( $x_vector, $y_vector );

    push( @derivatives, _slope( $p1, $p2 ) );

    while ( my $p3 = _getNextPoint( $x_vector, $y_vector ) ) {
        push( @derivatives, _slope( $p1, $p3 ) );

        $p1 = $p2;
        $p2 = $p3;
    }

    push( @derivatives, _slope( $p1, $p2 ) );

    return @derivatives;
}

sub _getNextPoint {
    my( $x_vector, $y_vector ) = @_;
    my $point;

    my $x = shift( @{$x_vector} );
    my $y = shift( @{$y_vector} );

    if ( defined( $x ) && defined( $y ) ) {
        $point->{x} = $x;
        $point->{y} = $y;
    }

    return $point;
}

sub _slope {
    my( $first, $second ) = @_;

    my $dx = ( $second->{x} - $first->{x} );
    my $dy = ( $second->{y} - $first->{y} );

    my $slope = 0;
    if ( defined( $dx ) && defined( $dy ) && ( $dx > 0 ) ) {
        $slope = ( $dy / $dx );
    }

    return $slope;
}
```

Yikes.  I can't help but notice that my version ended up being on the order of four times as long; however, about one-third of that increase is whitespace.  To my eyes, the use of whitespace, indentation, and grouping characters helps break down the program into manageable, coherent chunks.  And to the best of my knowledge, I didn't cheat and use any syntax that wasn't available at the time the original was written.

It didn't help that there were no tests included with the individual module; I made one simple test, which the original code and my code both pass (`prove -l t` from the top-level directory to run the test).  There's still plenty of room for additional testing, never mind the fact that neither version has any reasonable amount of input validation, error handling etc.

So, there's my assertion that Perl doesn't have to look like gobbledegook.
