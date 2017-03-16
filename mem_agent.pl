#!/usr/bin/perl

#calculate mem, cpu, swap usage from top


#first 5 lines can be skipped
#5 swap
#4 mem
#cpu

use warnings;
use strict;

my $date = `date`; chomp($date); 
(my $day, my $x, my $n,$date ) = split(" ", $date);
$date =~ s/:/_/g ;
my $hostname = `hostname`; chomp($hostname);
my $filename = "$hostname"."."."$date" ;
open my $fh, '>' ,$filename or die "$!\n";

sub top {
  
  my ($pid, $virt, $res, $cmd, $cpu);
  my %top_hash;
  my @top = `top -n 1 -m`;
  
  #calculate mem, cpu, swap usage

  my( $mem_total, $mem_used) = split(",",$top[3]);
  my( $swap_total, $swap_used) = split(",", $top[4]); 

  print( $mem_total, $mem_used);
  print ("\n");
  print ( $swap_total, $swap_used);
  print ("\n");


  for my $num(7..@top - 1) 
  {
    #print "$top[$num]";
    #my ( $pid ) = split(" ", $top[$num]);
    
    $top[$num] =~ s/\s+/\,/g;
    my @line = split("",$top[$num]);
    
    # for my $c(@line){ print "$c"; }
    #print("\n");
    #print("$line[6]\n");
    
    if( $line[6] eq ",") {  $top[$num] =~ s/,//; }
    
    #$top[$num] =~ s/,//;
    #my @words = split(",", $top[$num] );
    #print ("$words[4]\n");
    
   
    ( my $tmp0, my $tmp1, my $tmp2, my $tmp3,$virt,$res, my $tmp4, my $tmp7, $cpu, my $tmp6,my $tmp8, $cmd) = split(/,/, $top[$num]);
    #print ( "Virt:", $virt," ", "Res:", $res,"  ", "Command:","  ", $cmd, "  CPU:", $cpu, "\n");
    print $fh ( $cmd,",",$res,",",$virt,",",$cpu,"\n");
    
    #print("$top[$num]\n");
    #push(@{$top_hash{$cmd}}, $virt, $res); 

  }
=pod
  for my $key( sort {$a <=> $b} keys %top_hash)
 {
   print( @{$top_hash{$key}}[2] );
 }
=cut
 return;

}


top()

