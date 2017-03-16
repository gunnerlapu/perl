#!/usr/bin/perl

use warnings;
use strict;

my $file = "mem_stats";
open my $fh, ">>" , $file or die "$!\n";
my $threshold = 1000;


sub check_memory {

   my ( $host ) = @ARGV ;
   my %hash; 
   #my @output = `ssh ainet\@$host vmstat 1 2`;
   my @output = `vmstat 1 2`;
   my $date = `date`;
   my ( $run, $block, $swap, $free, $buff, $cache ) = split(" ", $output[2]);
   print "==========Memory stats for $host========\n";
   print "Running: $run\n"; 
   print "Blocked: $block\n";
   print "swap:   $swap\n";
   print "free: $free\n";
   print "buff : $buff\n";
   print "cache : $cache\n";
   #generate csv for mysql

   print $fh "$host,$run,$block,$swap,$free,$buff,$cache,$date";
   return;

}

&check_memory
