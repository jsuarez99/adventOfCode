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
my $t = 0;
    
#now loop through all permutations of that set
for(my $i = 0; $i < @containers; $i++){
    forcomb{
	if(vecsum(@containers[@_]) == $maxLtrs){
	    print "@containers[@_]\n";
	    $combinations++;
	    $t = 1; #found the minimum number of things
	}
    } scalar(@containers),$i;
    
    if($t == 1){
	print "Minimum number of containers: $i\n";
	print "Number of $i container combinations: $combinations\n";
	last;
    }
}
