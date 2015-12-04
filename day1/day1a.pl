use strict;

my $filename = "input";

open(my $fileh, $filename) or die "Could not find the file '$filename' $!";

my @parens;
if(my $row = <$fileh>){
    chomp $row;
    @parens = split(//,$row);

    my $floor = 0;
    for(my $i = 0; $i < @parens; $i++){
	if( $parens[$i] eq "(" ){
	    $floor++;
	}
	elsif( $parens[$i] eq ")" ){
	    $floor--;
	}
    }

    print "Final floor: $floor\n";
}
