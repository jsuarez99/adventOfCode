use strict;

my $filename = "input";

open(my $fileh, $filename) or die "Could not find the file '$filename' $!";

my $totalCodeChars = 0, my $totalEncChars = 0;
while(my $row = <$fileh>){
    chomp $row;

    $row =~ m/^\"(.*)\"$/;                    #get the string contents
    my $encStr = $1;
    $encStr =~ s/(\\|\")/\\\\/g;              #Encode all slashes, technically not correct but comes out to the same number of characters...
    $encStr = "\"\\\"" . $encStr . "\\\"\"";  #wrap the string in encoded quotes and regular quotes

    $totalCodeChars += split(//,$row);
    $totalEncChars += split(//,$encStr);
}

print "Total Encoded Characters: $totalEncChars\nTotal Code Characters: $totalCodeChars\n";
print "Answer: ".($totalEncChars - $totalCodeChars)."\n";
