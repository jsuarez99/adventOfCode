use strict;

my $input = "cqjxjnds";
my $newPW = $input;

while( !verify($newPW) ){
	$newPW = increment($newPW);
}

print "Verified: $newPW\n";

sub increment{
	my @pwStr = split(//,$_[0]);
	
	#Start at the last character in the string and work our way backwards
	for(my $i = (@pwStr)-1; $i >= 0; $i--){
		if($pwStr[$i] eq 'z'){
			$pwStr[$i] = 'a';
			next;
		}
		
		do{
			$pwStr[$i] = chr(ord($pwStr[$i])+1);
		}
		while($pwStr[$i] eq 'i' || $pwStr[$i] eq 'l' || $pwStr[$i] eq 'o');
		
		last;
	}
	
	return join('',@pwStr);
}

sub verify{
	my $pw = $_[0];
	
	#Check for the two sets of repeating characters
	#and the absence of i,l,o
	if( $pw =~ m/(\w)\1.*(\w)\2/ && $pw =~ m/[^ilo]/g){
	
		#now look for the sequential characters
		#I save this for last two save some execution time
		my @pwChars = split(//,$pw);
		
		for(my $i = 0; $i < (@pwChars) - 2; $i++){
			if( ord($pwChars[$i]) + 1 == ord($pwChars[$i+1]) && ord($pwChars[$i]) + 2 == ord($pwChars[$i+2]) ){
				return 1;
			}
		}
	}
	
	
	return 0;
}