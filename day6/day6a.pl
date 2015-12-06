use strict;

#this is a horribly inefficient solution, forgive me....

my $filename = "input";
open(my $fileh, $filename) or die "Could not find the file '$filename' $!";

my @lightArray; #The array of all our lights.

while(my $row = <$fileh>){
    chomp $row;
	
	#grab all the necessary parts of the line and store them in an array
	$row =~ m/^(turn off|turn on|toggle) (\d+),(\d+) through (\d+),(\d+)$/;
    my @cur = ($1,$2,$3,$4,$5);

	#go through our massive array and change the values
	for(my $x = $cur[1]; $x <= $cur[3]; $x++){
		for(my $y = $cur[2]; $y <= $cur[4]; $y++){			
			if($cur[0] eq "turn on"){
				$lightArray[$y][$x] = 1;
			}
			elsif($cur[0] eq "turn off"){
				$lightArray[$y][$x] = 0;
			}
			elsif($cur[0] eq "toggle"){
				$lightArray[$y][$x] = ($lightArray[$y][$x] == 0 || $lightArray[$y][$x] eq '') ? 1 : 0;
			}
		}
	}
}

my $numLit = 0;
for(my $x = 0; $x < 1000; $x++){
	for(my $y = 0; $y < 1000; $y++){
		if($lightArray[$y][$x]){
			$numLit++;
		}
	}
}

print "Number of lights lit: $numLit\n";