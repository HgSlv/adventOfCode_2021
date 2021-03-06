
my @Board = (3,5,1,2,5,4,1,5,1,2,5,5,1,3,1,5,1,3,2,1,5,1,1,1,2,3,1,3,1,2,1,1,5,1,5,4,5,5,3,3,1,5,1,1,5,5,1,3,5,5,3,2,2,4,1,5,3,4,2,5,4,1,2,2,5,1,1,2,4,4,1,3,1,3,1,1,2,2,1,1,5,1,1,4,4,5,5,1,2,1,4,1,1,4,4,3,4,2,2,3,3,2,1,3,3,2,1,1,1,2,1,4,2,2,1,5,5,3,4,5,5,2,5,2,2,5,3,3,1,2,4,2,1,5,1,1,2,3,5,5,1,1,5,5,1,4,5,3,5,2,3,2,4,3,1,4,2,5,1,3,2,1,1,3,4,2,1,1,1,1,2,1,4,3,1,3,1,2,4,1,2,4,3,2,3,5,5,3,3,1,2,3,4,5,2,4,5,1,1,1,4,5,3,5,3,5,1,1,5,1,5,3,1,2,3,4,1,1,4,1,2,4,1,5,4,1,5,4,2,1,5,2,1,3,5,5,4,5,5,1,1,4,1,2,3,5,3,3,1,1,1,4,3,1,1,4,1,5,3,5,1,4,2,5,1,1,4,4,4,2,5,1,2,5,2,1,3,1,5,1,2,1,1,5,2,4,2,1,3,5,5,4,1,1,1,5,5,2,1,1);

my $hFishes = {
    -1 => 0,
    0 => 0,
    1 => 0,
    2 => 0,
    3 => 0,
    4 => 0,
    5 => 0,
    6 => 0,
    7 => 0,
    8 => 0,
};

for (my $i = 0; $i < scalar @Board; $i++) {
    $hfishes->{$Board[$i]} += 1;
}

use Data::Dumper;
print ("\r =================Board=================== \r");
print Dumper $hfishes;
print ("\r");

for (my $i = 0; $i < 256; $i++) {
    cycleFishesHash($hfishes);
}

my $res = 0;

for (my $i = 0; $i < 9; $i++) {
    $res += $hfishes->{$i};
}

use Data::Dumper;
print ("\r =================Result=================== \r");
print $res;
print ("\r");

use Data::Dumper;
print ("\r =================Board=================== \r");
print Dumper $hfishes;
print ("\r");


sub cycleFishesHash {
    my ($hfishes) = @_;

    for (my $i = 0; $i < 9; $i++) {
        
        if ($hfishes->{$i} >= 0) {

            $hfishes->{$i - 1} += $hfishes->{$i};
            $hfishes->{$i} = 0;
        }
    }
    
    if ($hfishes->{-1} > 0) {

        $hfishes->{6} += $hfishes->{-1};
        $hfishes->{8} += $hfishes->{-1};
    
        
        $hfishes->{-1} = 0;
    }
    
    return $hfishes;
}

