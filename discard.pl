#!/usr/bin/perl -w

use strict;

my $idsfile = "discardIds.txt";
my $seqfile = "file.fasta";
my %ids  = ();
my @outA = ();


open FILE, $idsfile;
while(<FILE>) {
  chomp;
  $ids{$_} += 1;
}
close FILE;

local $/ = "\n>";  # read by FASTA record

open FASTA, $seqfile;
while (<FASTA>) {
    chomp;
    my $seq = $_;
    my ($id) = $seq =~ /^>*(\S+)/;  # parse ID as first word in FASTA header
    if (exists($ids{$id})) {
        }
		else{
		push (@outA, ">".$seq."\n");
		}
}
close FASTA;
open (OUT, ">output.fasta");
print OUT (@outA);
close (OUT);
