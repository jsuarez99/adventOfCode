use strict;
use List::Util qw(sum);
use Math::Combinatorics;

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
my @t = (0 .. 100);
my $c = Math::Combinatorics->new(count => 4,
				 data => [@t]
    );
#too slow...
while(my @stuff = $c->next_combination()){
    if(sum(@stuff) == 100){
	#print join(' ', @stuff)."\n";
    }
}
