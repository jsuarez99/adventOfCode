use strict;
use Digest::MD5 qw(md5 md5_hex md5_base64);

my $secretKey = "ckczppom";
my $number = 0;

for(; ; $number++){
    my $digest = md5_hex("$secretKey"."$number");
    if($digest =~ m/^000000.*/){
	print "$digest => $secretKey + $number\n";
	last;
    }
}
print "Number found\n";
