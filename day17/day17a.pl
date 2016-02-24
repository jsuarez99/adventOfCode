use strict;
use ntheory qw(forcomb forperm vecsum vecprod);

my $filename = "input";
open(my $fileh, $filename) or die "Could not find the file '$filename' $!";

my @containers;  #array of container sizes
while(my $row = <$fileh>){
    chomp $row;
    $row =~ m/(\d+)/;
    push(@containers, $1);
}

my $maxLtrs = 150;
my $combinations = 0;
    
#now loop through all permutations of that set
for(my $i = 0; $i < @containers; $i++){
    forcomb{
	if(vecsum(@containers[@_]) == $maxLtrs){
	    $combinations++;
	}
    } scalar(@containers),$i;
}

print "Number of container combinations: $combinations\n";
