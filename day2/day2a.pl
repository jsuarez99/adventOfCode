use strict;

my $totalPaper = 0;
my $filename = "input";
open(my $fileh, $filename) or die "Could not find the file '$filename' $!";

while(my $row = <$fileh>){
    chomp $row;
    print "$row; ";
    my @lwh = split(/x/,$row);
    my @sideAreas;

    push(@sideAreas, $lwh[0] * $lwh[1]);
    push(@sideAreas, $lwh[1] * $lwh[2]);
    push(@sideAreas, $lwh[0] * $lwh[2]);

    @sideAreas = sort { $a <=> $b } @sideAreas;
    
    print "Sorted side area: @sideAreas; ";

    my $packagePaper = (2 * $sideAreas[0]) + (2 * $sideAreas[1]) + (2 * $sideAreas[2])  + $sideAreas[0];
    print "paper sum: $packagePaper\n";

    $totalPaper += $packagePaper;
}

print "Total Paper Needed: $totalPaper\n";
