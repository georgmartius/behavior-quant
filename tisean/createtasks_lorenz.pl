#!/usr/bin/perl -w

use strict;


my $jobname = "lor_l";
my $name = "d2_" . $jobname;
#my $queue = "long,dedicated=1";
#my $numprocs = 1;
my $queue = "long,mem=10G,dedicated=1";
my $numprocs = 6;

my $submitfile = $name . "_submit.sh";
open SUBMIT , ">" . $submitfile or die "cannot write file";
print SUBMIT "#!/bin/bash\n";

my $datfolder = "../../../data/lorenz/";
my $opts = "-N0 -x 10000 -r 0.005";

my ($dat,$p1,$p2);
my $i=0;
my @jobs;
foreach $dat ("lorenz_noise0-005.dat", "lorenz_noise0-01.dat", "lorenz_noise0-02.dat"){
    my $stem = $dat;
    $stem =~ s/\.dat//;
    foreach $p1 ("-c 1   -M 1,10 -d 10 -t 30 -o " . $stem . "_d10",
    ) {
#    foreach $p2 (&range(0.4, 0.1, 1.01)){
       $i=$i+1;
       my $filename = $name . $i . ".sh";
       open FILE , ">" . $filename or die "cannot write file";
       print FILE <<EOI;
#!/bin/sh
if \$HOME/bin/d2 $datfolder$dat $p1 $opts; then
    rm -f $filename;
fi
EOI
       close(FILE);
       chmod 0744, $filename;
       push @jobs, $filename;
    }
}

my @chunks;
push @chunks, [ splice @jobs, 0, $numprocs ] while @jobs;
my $k=0;
my $c;
my $batchname;
my $job;
foreach $c (@chunks) {
    $batchname = "batch_"  . $name . $k . ".sh";
    open BATCH , ">" . $batchname or die "cannot write file";
    print BATCH <<EOI;
#!/bin/bash
#\$ -N $jobname$i
#\$ -j y
#\$ -cwd
#\$ -o $batchname.out
#\$ -l $queue
EOI
    foreach $job (@$c){
        print BATCH "./$job &\n"
    }
    print BATCH <<EOI;
for job in `jobs -p`; do
  wait \$job
done
EOI
    close BATCH;
    print SUBMIT "qsub  $batchname\n";
    $k=$k+1;
}

close(SUBMIT);
chmod 0755, $submitfile;

sub range {
    my $min=shift;
    my $step=shift;
    my $max=shift;
    my @array;
    for(my $i=$min; $i<$max; $i+=$step){
	push @array,$i;
    }
    return @array;
}
