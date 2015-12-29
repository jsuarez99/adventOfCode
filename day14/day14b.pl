use strict;

my $filename = "input";
open(my $fileh, $filename) or die "Could not find the file '$filename' $!";

#Hash with reindeer's speeds and rest times
# {name} -> [speed, run_time, rest_time]
my %reindeer;
#tracker will keep track of the reindeer's positions, state, points, and time
# {name} -> [current_distance, time_counter, state (1 for running, 0 for resting),points]
my %tracker;
while(my $row = <$fileh>){
    $row =~ m/(\w+) can fly (\d+) km\/s for (\d+) seconds, but then must rest for (\d+) seconds\./;
	$reindeer{$1} = [$2, $3, $4];
	$tracker{$1} = [0,$3, 1, 0];
}

for(my $tick = 0; $tick < 2503; $tick++){
	my $topScore = 0;
	foreach my $name (keys %tracker){
		if($tracker{$name}->[2] == 1 && $tracker{$name}->[1] != 0){ #RUNNING
			$tracker{$name}->[0] += $reindeer{$name}->[0];
			$tracker{$name}->[1] -= 1;
		}
		elsif($tracker{$name}->[2] == 0 && $tracker{$name}->[1] != 0){ #RESTING
			$tracker{$name}->[1] -= 1;
		}
		
		if($tracker{$name}->[2] == 1 && $tracker{$name}->[1] == 0){ #run time is done
			$tracker{$name}->[1] = $reindeer{$name}->[2];
			$tracker{$name}->[2] = 0;
		}
		elsif($tracker{$name}->[2] == 0 && $tracker{$name}->[1] == 0){ #rest time is done
			$tracker{$name}->[1] = $reindeer{$name}->[1];
			$tracker{$name}->[2] = 1;
		}
		
		if($tracker{$name}->[0] > $topScore){ #Set the top score for this second of the race
			$topScore = $tracker{$name}->[0];
		}
	}
	
	#Distribute scores for all matching the top score
	foreach my $name (keys %tracker){
		if($tracker{$name}->[0] == $topScore){
			$tracker{$name}->[3] += 1;
		}
	}
}

#print results
my $winner;
my $highestScore = 0;
print "At 2503 seconds:\n";
foreach my $name (keys %tracker){
	if($tracker{$name}->[3] > $highestScore){
		$highestScore = $tracker{$name}->[3];
		$winner = $name;
	}
	print "$name earned $tracker{$name}->[3] points\n";
}
print "$winner is the winner!\n";