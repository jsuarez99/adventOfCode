use strict;

my $filename = "input";

open(my $fileh, $filename) or die "Could not find the file '$filename' $!";

my $totalCodeChars = 0, my $totalStringChars = 0;
while(my $row = <$fileh>){
    chomp $row;
    
    $row =~ m/^\"(.*)\"$/;
    my $innerStr = $1;
    $innerStr =~ s/(\\x[a-f0-9]{2}|\\\"|\\\\)/|/g;

    $totalCodeChars += split(//,$row);
    $totalStringChars += split(//,$innerStr);
}

print "Total Code Characters: $totalCodeChars\nTotal String Characters: $totalStringChars\n";
print "Answer: ".($totalCodeChars - $totalStringChars)."\n";
