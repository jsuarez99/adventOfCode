use strict;

my $filename = "input";
open(my $fileh, $filename) or die "Could not find the file '$filename' $!";

if(my $row = <$fileh>){
    chomp $row;
    my @parens = split(//,$row);

    my $floor = 0;
    for(my $i = 0; $i < @parens; $i++){
	if( $parens[$i] eq "(" ){
	    $floor++;
	}
	elsif( $parens[$i] eq ")" ){
	    $floor--;
	}

	if($floor == -1){
	    print "Entered -1 at ".($i + 1)."\n";
	    last;
	}
    }

    print "Final floor: $floor\n";
}
