use strict;

my $filename = "input";

open(my $fileh, $filename) or die "Could not find the file '$filename' $!";

if(my $row = <$fileh>){
    chomp $row;
	my @delim = split(',',$row);
    my $sum = 0;
	
	for(@delim){
		if( $_ =~ m/(-?\d+)/ ){
			$sum += $1;
		}
	}
	
	print "Sum of all numbers in file: $sum\n";
}
