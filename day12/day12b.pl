use strict;

my $filename = "input";
open(my $fileh, $filename) or die "Could not find the file '$filename' $!";

if(my $row = <$fileh>){
    chomp $row;
    $row = &removeRed($row);

    my @delim = split(',',$row);
    my $sum = 0;

    my $open = 0;   #if >1, we are inside of an object/hash
    my $redFound = 0;  #if =1, we are inside of a red object
    for(@delim){
	if( $_ =~ m/(-?\d+)/){
	    $sum += $1;
	}
    }
    
    print "Sum of all numbers in file (minus RED property): $sum\n";
}

#Function to remove all objects with a "red" value
sub removeRed{
    my $str = $_[0];

    #found an object with a red value
    while($str =~ m/\:\"red\"/){

	#store the first position of the occurance and
	#split the string into an array
	my $pos = index($str,':"red"');
	my @strChrs = split(//,$str);

	#Begin going backwards to find the open bracket
	my $leftBrk = 1;
	my $leftBrkPos;
	for(my $i = $pos; $i > 0; $i--){
	    #If a close bracket is found, we'll need
	    #to find another open bracket
	    if($strChrs[$i] eq "}"){
		$leftBrk++;
	    }

	    if($strChrs[$i] eq "{"){
		$leftBrk--;
	    }

	    #when the counter is zero, we've found the
	    #beginning of the object
	    if($leftBrk == 0){
		$leftBrkPos = $i;
		last;
	    }
	}

	#Now do the same in reverse to find the close bracket
	my $rightBrk = 1;
	my $rightBrkPos;
	for(my $i = $pos; $i < @strChrs; $i++){
	    if($strChrs[$i] eq "{"){
		$rightBrk++;
	    }
	    
	    if($strChrs[$i] eq "}"){
		$rightBrk--;
	    }

	    if($rightBrk == 0){
		$rightBrkPos = $i;
		last;
	    }
	}

	#Now we have the position of the open and close of the object,
	#so splice the whole object out of the array
	splice(@strChrs,$leftBrkPos,($rightBrkPos-$leftBrkPos)+1);

	#Join the array back together with the removed object and begin
	#the loop again if more objects with red still exist
	$str = join('',@strChrs);
    }
    return $str;
}
