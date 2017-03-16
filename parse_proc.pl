#!/usr/bin/perl

use strict;
use warnings;

#parse the proc filesystem for memory structure of a process, open descriptors, IO stats

sub proc {

   my ( $pid, $opt) = @ARGV;
   my $file = "/proc/" .$pid . "/maps";
   open my $fh, '<', $file or die "Can't open files $!\n";
   my $stack_adr = 0;
   my $heap_adr = 0;
   my $proc_adr = 0;

   print "Stack Address ----------\n";
   while(<$fh>)
   {
      if ( $_ =~ /stack/ ){
        ($stack_adr) = split("-");
        print "Stack begins at $stack_adr\n";
      }
      if ( $_ =~ /heap/ ){
        ($heap_adr) = split("-");
         print "Heap begins at $heap_adr\n";
     }

   }
  close $fh;

}
sub io_stat {


   my( $pid, $opt) = @ARGV;
   my $file = "/proc/" .$pid . "/io";
   open my $fh, '<', $file or die "Can't open files $!\n";

   print "IO stats ---------------  \n";
   while(<$fh>)
   {
       print $_ ;

   }
  close $fh;
}

sub list_fd {
   #my $fd_ls;
   my( $pid, $opt) = @ARGV;
   my $dir = "/proc/" .$pid . "/fd";
   my @out_ls = `cd $dir ; ls -ltr`;

   print "\n";
   print "Opened File descriptors----------- \n";

   for my $line(@out_ls)
  {
   my ($tmp, $fd_ls ) = split(/->/,$line);  
    print $fd_ls;
  } 

}
&list_fd;
print "\n";
&proc;
print "\n";
&io_stat;
