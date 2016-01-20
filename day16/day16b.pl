use strict;

my $filename = "input";
open(my $fileh, $filename) or die "Could not find the file '$filename' $!";

my %gifter = ( "children" => 3,
	       "cats" => 7,
	       "samoyeds" => 2,
	       "pomeranians" => 3,
	       "akitas" => 0,
	       "vizslas" => 0,
	       "goldfish" => 5,
	       "trees" => 3,
	       "cars" => 2,
	       "perfumes" => 1 );

my @sue;
while(my $row = <$fileh>){
    chomp $row;
    $row =~ m/Sue (\d+): (\w+): (\d+), (\w+): (\d+), (\w+): (\d+)/;

    $sue[$1] = { $2 => $3,
		 $4 => $5,
		 $6 => $7 };
}

#Search each Sue's properties against the gifter's properties
for(my $i = 1; $i < @sue; $i++){
    my $isGifter = 1;
    foreach my $prop (keys %{$sue[$i]}){

	#if less than or equal, doesn't match
	if( ($prop eq "cats" || $prop eq "trees") && $sue[$i]{$prop} <= $gifter{$prop} ){
	    $isGifter = 0;
	    last;
	}

	#If greater than or equal, doesn't match
	if( ($prop eq "pomeranians" || $prop eq "goldfish") && $sue[$i]{$prop} >= $gifter{$prop} ){
	    $isGifter = 0;
	    last;
	}

	#This sue has a non matching value, end the comparison
	if( $sue[$i]{$prop} != $gifter{$prop} && 
	    !($prop eq "cats" || $prop eq "trees" || $prop eq "pomeranians" || $prop eq "goldfish") ){
	    $isGifter = 0;
	    last;
	}	
    }

    #If isGifter is still true, print out the number of Aunt
    if($isGifter){
	print "Sue $i is the gifter!\n";
    }
}
