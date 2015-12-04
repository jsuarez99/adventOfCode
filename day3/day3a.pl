use strict;

my $filename = "input";
open(my $fileh, $filename) or die "Could not find the file '$filename' $!";

if(my $row = <$fileh>){
    chomp $row;
    my @directions = split(//,$row);

    my %houses = ( "0,0" => 1);
    my $floor = 0, my $horiz = 0, my $vert = 0;
    for(my $i = 0; $i < @directions; $i++){
	if( $directions[$i] eq "<" ){
	    $horiz--;
	}
	elsif( $directions[$i] eq ">" ){
	    $horiz++;
	}
	elsif( $directions[$i] eq "v" ){
	    $vert--;
	}
	elsif( $directions[$i] eq "^" ){
	    $vert++;
	}

	if(exists $houses{$horiz.",".$vert}){
	    $houses{$horiz.",".$vert}++;
	}
	else{
	    $houses{$horiz.",".$vert} = 1;
	}

	print "$horiz,$vert $directions[$i] ".$houses{$horiz.",".$vert}."\n";
    }

    print "Number of houses that received gifts: ".(keys %houses)."\n";
}
