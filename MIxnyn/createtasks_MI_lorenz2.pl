#!/usr/bin/perl -w
# sample perl script to create tasks.csv file
#  for scanning a parameter space
#  here we have 3 parameters p1 and p2 and filestem

use strict;

my $jobname = "SN_";
my $name = "MIL_" . $jobname;
my $queue = "long,mem=110G";
my $numprocs = 12;

my $submitfile = "batch_" . $name . "_submit.sh";
open SUBMIT , ">" . $submitfile or die "cannot write file";
print SUBMIT "#!/bin/bash\n";

my $datbase = "/clusterhome/martius/MIxnyn/lorenz/large/";

my ($filestem,$p1,$p2);
my $i=0;
my @jobs;
foreach $filestem ("lorenz","lorenz_noise0-01"){
    my $dat = $datbase . $filestem . ".dat";
    foreach $p2 (0.001, 0.002,0.005, 0.01, 0.02, 0.05, 0.1, 0.2, 0.5, 1.0, 2.0, 5.0, 10.0, 20.0){
        my $p2s = $p2 =~ s/\./-/r;
        foreach $p1 (" \"x\"   6 1  0 $p2 20 > " . $filestem ."_n". $p2s ."k20_d1.pi" ,
                     " \"x\"   6 10 0 $p2 20 > " . $filestem ."_n". $p2s ."k20_d10.pi",
                     " \"x\"   6 18 0 $p2 20 > " . $filestem ."_n". $p2s ."k20_d18.pi"
                     ) {
            $i=$i+1;
            my $filename = $name . $i . ".sh";
            open FILE , ">" . $filename or die "cannot write file";
            print FILE <<EOI;
#!/bin/sh
export PATH=\$HOME/bin:\$PATH;
if \$HOME/bin/calcpifromdata.pl $dat $p1; then #EDIT HERE THE PROGRAM
    rm -f $filename;
fi
EOI
            close(FILE);
            chmod 0744, $filename;
            push @jobs, $filename;
        }
    }
}

my @chunks;
push @chunks, [ splice @jobs, 0, $numprocs ] while @jobs;
my $k=0;
my $c;
my $batchname;
my $job;
foreach $c (@chunks) {
    $k=$k+1;
    $batchname = "batch_"  . $name . $k . ".sh";
    open BATCH , ">" . $batchname or die "cannot write file";
    print BATCH <<EOI;
#!/bin/bash
#\$ -N $jobname$k
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
rm -f $batchname;
EOI
    close BATCH;
    print SUBMIT "qsub  $batchname\n";
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
