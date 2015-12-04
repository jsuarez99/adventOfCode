use strict;

my $filename = "input";
open(my $fileh, $filename) or die "Could not find the file '$filename' $!";

if(my $row = <$fileh>){
    chomp $row;
    my @directions = split(//,$row);

    my %sHouses = ( "0,0" => 1); #santa
    my %rsHouses = ( "0,0" => 1); #Robo-Santa
    my %allHouses = ( "0,0" => 1); #Both
    my $floor = 0, my $shoriz = 0, my $svert = 0, my $rshoriz = 0, my $rsvert = 0;
    for(my $i = 0; $i < @directions; $i++){
	#Santa goes on x%2 == 0
	if($i % 2 == 0){
	    if( $directions[$i] eq "<" ){
		$shoriz--;
	    }
	    elsif( $directions[$i] eq ">" ){
		$shoriz++;
	    }
	    elsif( $directions[$i] eq "v" ){
		$svert--;
	    }
	    elsif( $directions[$i] eq "^" ){
		$svert++;
	    }
	    
	    if(exists $sHouses{$shoriz.",".$svert}){
		$sHouses{$shoriz.",".$svert}++;
	    }
	    elsif(!exists $sHouses{$shoriz.",".$svert}){
		$sHouses{$shoriz.",".$svert} = 1;
	    }
	    print "SANTA => $shoriz,$svert $directions[$i] ".$sHouses{$shoriz.",".$svert}."\n";
	}
	#Robo-Santa goes on x%2 == 1
	else{
	    if( $directions[$i] eq "<" ){
		$rshoriz--;
	    }
	    elsif( $directions[$i] eq ">" ){
		$rshoriz++;
	    }
	    elsif( $directions[$i] eq "v" ){
		$rsvert--;
	    }
	    elsif( $directions[$i] eq "^" ){
		$rsvert++;
	    }
	    
	    if(exists $rsHouses{$rshoriz.",".$rsvert}){
		$rsHouses{$rshoriz.",".$rsvert}++;
	    }
	    elsif(!exists $rsHouses{$rshoriz.",".$rsvert}){
		$rsHouses{$rshoriz.",".$rsvert} = 1;
	    }
	    print "ROBO-SANTA => $rshoriz,$rsvert $directions[$i] ".$rsHouses{$rshoriz.",".$rsvert}."\n";
	}

    }

    for my $keys (keys %sHouses){
	$allHouses{$keys} = 0;
    }

    for my $keys (keys %rsHouses){
	$allHouses{$keys} = 0;
    }

    print "Number of houses that received gifts: ".(keys %rsHouses) . " " . (keys %sHouses)."\n";
    print "Number of unique houses that received gifts: ".(keys %allHouses)."\n";
    
}
