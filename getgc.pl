#!/usr/bin/perl

use strict;
use warnings;

local $/ = '>';

while (<>) {
    chomp;
    /\S/ or next;
    my ( $id, $seq ) = /(.+?)\n(.+)/s;
    $seq =~ s/\n//g;

    my $GCcount = $seq =~ tr/GC//;
    printf "%s, %.2f%%\n", ">$id", ( $GCcount / length $seq ) * 100;
}
