use strict;

my $totalRibbon = 0;
my $filename = "input";
open(my $fileh, $filename) or die "Could not find the file '$filename' $!";

while(my $row = <$fileh>){
    chomp $row;
    print "$row; ";
    
    my @lwh = sort { $a <=> $b } split(/x/,$row);
    print "Sorted side lengths: @lwh; ";

    my $ribbonLen = ($lwh[0] * 2) + ($lwh[1] * 2);
    my $bowLen = $lwh[0] * $lwh[1] * $lwh[2];

    print " ribbon: $ribbonLen, bow: $bowLen; total: " . ($ribbonLen + $bowLen) . "\n";

    $totalRibbon += $ribbonLen + $bowLen;
}

print "Total Paper Needed: $totalRibbon\n";
