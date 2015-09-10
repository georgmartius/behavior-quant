#!/usr/bin/perl -w

use File::Basename;

my $argc=scalar @ARGV;
my @args = @ARGV;
while(shift){}
if ($argc<4) {
    print "Usage: calcpifromdata.pl logfile channelpattern embedding delay [len] [noise]\n";
    print "\t logfile: file with column data and column labels (#C) useable by selectcolumns.pl\n";
    print "\t channelpattern: pattern for selecting the columns, see selectcolumns.pl\n";
    print "\t embedding: number of embeddings to use (1..embedding)\n";
    print "\t delay: number of steps between subsequent data points\n";
    print "\t len: number of points to use (0 or nothing means all)\n";
    print "\t noise: noise stength (1e-8 is default)\n";
    exit;
}


my $file=$args[0];
my $pattern=$args[1];
my $embedding=$args[2];
my $delay=$args[3];
my $len;
if($args[4]) {
    $len=$args[4];
}else{
    $len=0
};
my $noise = $args[5] ? $args[5] : "";

my $tmpdir = "/clusterhome/martius/tmp/";
my $dir = $tmpdir . $$ . ".tmp/";
mkdir ($dir) or die "cannot create dir";

my $selected = $dir . (basename $file) . ".sel.dat";
my $cmd = "selectcolumns.pl \"" .  $pattern . "\" < " .  $file . " 2>&1 1> " . $selected;
print STDERR $cmd . "\n";
my @selectoutput = `$cmd`;
scalar @selectoutput > 1 or die "selectcolumns failed";
my $cols = scalar(split(/ /,$selectoutput[1]))-1;
$cols >= 1 or die "selectcolumns failed (no cols)";
print STDERR "columns: $cols\n";

my $embed;
for ($embed = 1; $embed <= $embedding; $embed++) {

    my $arranged = $dir. (basename $file) . "_arranged_". $embed . "_.dat";
    my $cmd = "arrangedata4pi.pl $embed $delay < $selected 2>&1 1> $arranged";
    print STDERR $cmd . "\n";
    my $lines = `$cmd`;
    my $datacols = $cols * $embed;
    $lines=$len if($len>0 && $len < $lines);
    $cmd = "MIxnyn $arranged $datacols $datacols ".  ($lines-1) . " 4 " . $noise;
    print STDERR $cmd . "\n";
    my $mi = `$cmd`;
    # again with half the data (validation)
    $cmd = "MIxnyn $arranged $datacols $datacols ".  ($lines/2) . " 4 " . $noise;
    print STDERR $cmd . "\n";
    my $mi2 = `$cmd`;
    print "$embed\t$datacols\t" . ($noise? $noise : 0.0)
        . "\t" . ($mi+1.0-1.0) . "\t" . ($mi2+1.0-1.0) . "\n";
}

`rm -rf $dir`;


