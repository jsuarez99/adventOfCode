use strict;
use Algorithm::Permute;  #Permutates an array VERY quickly

#Change to either inputa or inputb for whichever part to solve
my $filename = "inputb";
open(my $fileh, $filename) or die "Could not find the file '$filename' $!";

my %family;
while(my $row = <$fileh>){
    chomp $row;

    #get all necessary info from the line into a hash of arrays of arrays
    $row =~ m/(\w+) would (lose|gain) (\d+) .* to (\w+)/;
    $family{$1}{$4} = $2 eq "lose" ? "-$3" : $3;
}

my $bestSeating; #hold the top seating arrangement
my @members = keys %family;
my $numMembers = @members;
my $change = 0;

Algorithm::Permute::permute{
    my $total = 0;
    
    for(my $i = 0; $i < $numMembers; $i++){
	#we hit the end of the list, loop around
	if($i == ($numMembers-1) ){
	    $total += $family{$members[0]}{$members[$numMembers-1]} + $family{$members[$numMembers-1]}{$members[0]};
	}
	#add this family member's change in happiness and the one next to him/her
	else{
	    $total += $family{$members[$i]}{$members[$i+1]} + $family{$members[$i+1]}{$members[$i]};
	}
    }

    if($total > $change){
	$change = $total;
	$bestSeating = join(',',@members);
    }
} @members;

print "Best seating arrangement: $bestSeating with change of $change\n";
