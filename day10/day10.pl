use strict;

my $input = "1321131112";

for(my $k = 0; $k < 50; $k++){
    $input = &lookAndSay($input);
}

print "Result: ".split(//,$input)."\n";

sub lookAndSay(){
    my @digits = split(//,$_[0]);
    my $output;
    for(my $i = 0; $i < @digits;){
	my $numTimes = 1;  
	my $j = $i+1;      #counter to look ahead for the same digit
	
	#Keep counting the number of occurances of the current digit
	while($digits[$i] == $digits[$j]){
	    $numTimes++;
	    $j++;
	}

	#Push the number of occurances and the digit itself to the output
	$output .= "$numTimes"."$digits[$i]";

	#Set the $i counter to the next different digit in the string
	$i = $j;
    }
    return $output;
}
