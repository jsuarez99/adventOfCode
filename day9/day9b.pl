use strict;

my $filename = "input";
open(my $fileh, $filename) or die "Could not find the file '$filename' $!";

my %cityMap;
while(my $row = <$fileh>){
    chomp $row;
    $row =~ m/(\w+) to (\w+) = (\d+)/;

    $cityMap{$1}{$2} = $3;
    $cityMap{$2}{$1} = $3;
}

my @cities = keys %cityMap;
my @longestPaths;
my $longestPathIndex = 0;

for(my $i = 0; $i < @cities; $i++){
    $longestPaths[$i] = [$cities[$i],0];
    my $curCity = $cities[$i];
    while(1){
	my $maxDist = 0;
	my $nextCity;
	my @connectingCities = keys $cityMap{$curCity};
	for my $destination (@connectingCities){
	    #This is already in the path, skip it
	    if(index($longestPaths[$i][0],$destination) > -1){
		next;
	    }
	    #Save the longest path from this city 
	    if($cityMap{$curCity}{$destination} > $maxDist){
		$maxDist = $cityMap{$curCity}{$destination};
		$nextCity = $destination;
	    }
	}

	#all cities are already included, path is complete.
	if($maxDist == 0){
	    last;
	}
	else{
	    $longestPaths[$i][0] .= ",$nextCity";
	    $longestPaths[$i][1] += $maxDist;
	    $curCity = $nextCity;
	}
    }

    #check if the current path is longer than the longest path so far
    if( $longestPaths[$i][1] > $longestPaths[$longestPathIndex][1]){
	$longestPathIndex = $i;
    }
}

print "Longest Path: $longestPaths[$longestPathIndex][0] => $longestPaths[$longestPathIndex][1]\n";
