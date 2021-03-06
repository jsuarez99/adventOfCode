use strict;

my $filename = "input";

open(my $fileh, $filename) or die "Could not find the file '$filename' $!";

my $numNiceWords = 0;
while(my $row = <$fileh>){
    chomp $row;

	if($row =~ m/([aeiou].*){3}/ && $row =~ m/([a-z])\1/ && !($row =~ m/(ab|cd|pq|xy)/) ){
		print "Nice: $row\n";
		$numNiceWords++;
	}
	else{
		print "Naughty: $row\n";
	}
}

print "$numNiceWords nice words found.";