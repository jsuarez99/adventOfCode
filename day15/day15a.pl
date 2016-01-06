use strict;
use ntheory qw(forcomb forperm vecsum vecprod);

my $filename = "input";
open(my $fileh, $filename) or die "Could not find the file '$filename' $!";

my @ingredients;  #array of arrays to store ingredient properties
my @teaspoons;    #array that will store the number of tsps of each ingredient
while(my $row = <$fileh>){
    chomp $row;
    $row =~ m/(\w+): capacity (-?\d+), durability (-?\d+), flavor (-?\d+), texture (-?\d+), calories (-?\d+)/;
    push(@ingredients, [$1, $2, $3, $4, $5, $6]);
    push(@teaspoons, 0);
}

my $topScore = 0; #store the best score of ingredients
my $maxIngr = 100;
my @range = (0 .. 100);

#loop through all 4 number combinations adding up to 100
forcomb{
    if(vecsum(@range[@_]) == $maxIngr){
	my @tmp = @range[@_];

	#now loop through all permutations of that set
	forperm{
	    my @tmp2 = @tmp[@_];

	    #calculate the score and save the top score
	    my $score = getScore(\@tmp2);
	    if($score > $topScore){
		$topScore = $score;
		@teaspoons = @tmp2;
	    }
	} scalar(@tmp);
	
    }
} scalar(@range),scalar(@ingredients);


print "The top score for these ingredients is: $topScore\n";

#calculates the score of the recipe
#pass in the array of teaspoons per ingredient as an argument
sub getScore(){
    my @spoons = @{$_[0]};
    my @scoreArr = (0,0,0,0);

    #Add together all of the ingredients multiplied by teaspoons
    for(my $i = 0; $i < @ingredients; $i++){
	$scoreArr[0] += $ingredients[$i][1] * $spoons[$i];
	$scoreArr[1] += $ingredients[$i][2] * $spoons[$i];
	$scoreArr[2] += $ingredients[$i][3] * $spoons[$i];
	$scoreArr[3] += $ingredients[$i][4] * $spoons[$i];
    }

    #If any ingredient is less than zero, set to 0
    for(my $i = 0; $i < @scoreArr; $i++){
	if($scoreArr[$i] < 0){
	    $scoreArr[$i] = 0;
	}
    }

    #return the product of the scores in the array
    return vecprod(@scoreArr);
}
