use strict;

#Change from inputa to inputb depending on which part you want to solve
my $filename = "inputb";

open(my $fileh, $filename) or die "Could not find the file '$filename' $!";

#Each line will be stored with the output circuit as the key
#the value will be an array consisting of [inputA, operator, inputB]
my %wirings;

while(my $row = <$fileh>){
    chomp $row;
    my @circuit = split(' -> ',$row);
    $circuit[0] =~ m/([a-z0-9]*)?\s?(NOT|OR|AND|LSHIFT|RSHIFT)?\s?([a-z0-9]*)?/;
    
    $wirings{$circuit[1]} = [$1, $2, $3];
}

#Get the value of any letter of any wire
print "Value of a: ".&getValueOf('a')."\n";


#Recursive function to find the value of a wire (letter)
#The only input is the letter(s) of the wire.
sub getValueOf{
    my $key = $_[0];
    my ($inpA, $inpB);

    #If the value passed in is a number, return that number
    if($key =~ m/[0-9]+/){
	return $key;
    }
    #If the value is alphabetic, we need to find the value it receives
    elsif(exists $wirings{$key}){
	my @wArr = @{$wirings{$key}};

	#If not empty, recursively call this function. Only numeric values will
	#be returned, so when completed, replace the wire's letter value to the
	#returned value in the hash's array.
	if($wArr[0] ne ''){
	    $inpA = &getValueOf($wArr[0]);
	    $wirings{$key}[0] = $inpA;
	}
	if($wArr[2] ne ''){
	    $inpB = &getValueOf($wArr[2]);
	    $wirings{$key}[2] = $inpB;
	}

	#Run the appropriate operator on the input(s)
	if($wArr[1] eq 'NOT'){
	    return ~$inpB;
	}
	elsif($wArr[1] eq 'AND'){
	    return $inpA & $inpB;
	}
	elsif($wArr[1] eq 'OR'){
	    return $inpA | $inpB;
	}
	elsif($wArr[1] eq 'LSHIFT'){
	    return $inpA << $inpB;
	}
	elsif($wArr[1] eq 'RSHIFT'){
	    return $inpA >> $inpB;
	}
	elsif($wArr[1] eq ''){  #Direct value with no operators, return the first input
	    return $inpA;
	}
	else{
	    die("Strange input encountered: '$key $wArr[0] $wArr[1] $wArr[2]'\n");
	}
	
    }
    else{
	die("Strange input encountered: '$key'\n");
    }
}
