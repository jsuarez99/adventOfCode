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

my $numCities = keys %cityMap;
print "number of cities: $numCities\n";
for my $depart (keys %cityMap){
    for my $destination (keys $cityMap{$depart}){
	print "$depart -> $destination = $cityMap{$depart}{$destination}\n";
    }
}
