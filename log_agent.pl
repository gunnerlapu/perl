#!/usr/bin/perl

use strict;
use warnings;
use Data::Dumper;

#parse system logs, and generate counts per error type

sub log_cnt {

    my($logfile) = @_ ;
    open my $fh, '<', $logfile or die "open file failed $!";
    my %lg_hash;
    my $cnt=1;

    while(<$fh>)
    {
       my($mth, $day, $time, $hosts,$proc) = split(/ /);
       my($tmp, $message) = split(/[a-zA-Z]:/);
      #print "$proc -> $message\n";
       
       if( exists $lg_hash{$proc} and $message eq @{$lg_hash{$proc}}[0])
       {
          $cnt = @{$lg_hash{$proc}}[1];
          $cnt = $cnt + 1;
          @{$lg_hash{$proc}}[1] = $cnt; 
 
       }
       else
       {
         push @{$lg_hash{$proc}}, $message, $cnt;
       }     
    }
  #print Dumper(%lg_hash);
  gen_csv(\%lg_hash);
  return;

}
sub gen_csv {

   my( $href) = @_;
   my $hst = `hostname`; chomp($hst);
   my $date = `date`; chomp($date);
 
   open my $fh, '>>', $hst.".lgcnt.csv" or die "can't open file $!\n";  
   foreach my $key ( keys %{$href})
   {
       print $fh "$date,$hst,$key,${$href}{$key}[0],${$href}{$key}[1]\n";
     
   } 

}

&log_cnt("/var/log/messages");
