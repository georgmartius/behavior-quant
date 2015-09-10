#!/usr/bin/perl -w

my $argc=scalar @ARGV;
my @args = @ARGV;
while(shift){}
if ($argc<2) {
    print "Usage: arrangedata4pi.pl num delay < logfile > newlogfile \n";
    print "\t num: number of data sets used for past and future (each)\n";
    print "\t delay: number of steps between subsequent data points\n";
    exit;
}


my @buffer;
my $i=0;
my $numlines=0;
my $num=$args[0];
my $delay=$args[1];
my $buffersize=2*$num*($delay+1);
while(<>){
    my $line=$_;
    if($line =~ /^#/) # comment line
    {
    } else{ # normal data line
        $line =~ s/^\s+//; # remove leading space
        chomp $line;       # remove tailing space
        $buffer[$i % $buffersize]=$line;
        if($i>=$delay*(2*$num-1)){
            my $count;
            for ($count = 2*$num-1; $count >= 0; $count--) {
                print $buffer[($i-$delay*$count) % $buffersize] . " ";
            }
            print "\n";
            $numlines++;
        }
        $i++;
   }
}
print STDERR $numlines . "\n";



