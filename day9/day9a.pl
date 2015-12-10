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
my @shortestPaths;  #Will be an array of arrays each holding [path, total_distance]
my $shortestPathIndex = 0; #index of the final answer

for(my $i = 0; $i < @cities; $i++){
    $shortestPaths[$i] = [$cities[$i],0];
    my $curCity = $cities[$i];

    while(1){
	my $minDist = 9999;
	my $nextCity;
	my @connectingCities = keys $cityMap{$curCity};
	for my $destination (@connectingCities){
	    #This city is already in the path, skip it
	    if(index($shortestPaths[$i][0],$destination) > -1){
		next;
	    }
	    #Save the shortest path from this city
	    if($cityMap{$curCity}{$destination} < $minDist){
		$minDist = $cityMap{$curCity}{$destination};
		$nextCity = $destination;
	    }
	}

	#all cities are already included, path is complete.
	if($minDist == 9999){
	    last;
	}
	#Save the next leg of the trip, set the curCity to nextCity
	else{
	    $shortestPaths[$i][0] .= ",$nextCity";
	    $shortestPaths[$i][1] += $minDist;
	    $curCity = $nextCity;
	}
    }

    #Check if this path is shorter than the current shortest path
    if( $shortestPaths[$i][1] < $shortestPaths[$shortestPathIndex][1]){
	$shortestPathIndex = $i;
    }
}

print "Shortest Path: $shortestPaths[$shortestPathIndex][0] => $shortestPaths[$shortestPathIndex][1]\n";
