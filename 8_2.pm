use Data::Dumper;

my @Board = (
    'dacefg fegab de dceb bedag dae bcgaefd bdacg fbgcad bgedca | acfebgd de dbagc deagcb',
'cfgda fdebgc bfcdeag dbg afgedb efbad bg cdfeab gabdf abeg | dbg fbedgca gbea gbae',
'defgca efgbadc ecgba gecbfd db dabegf aebdg gdfae deb adfb | dcgaef edb bed becgdfa',
);

my $aDictionary = ['1','7','4','8'];

my $aDictionary = ['cf','bcdf','acf','abcdefg'];

my $bar = 'abdfg';

if ($bar =~ /[c,g]/) {

    print ("\r =================Result=================== \r");
    print "Sum: $Sum \r";
}


# acdeg => 2
# acdfg => 3
# abdfg => 5

# abdefg => 6
# abcdfg => 9
# abcefg => 0


my $aDictionaryCount = [2,3,4,7];

my $CountBoard = scalar @Board;

my $Sum = 0;

for (my $i = 0; $i < $CountBoard; $i++) {

    my $hDictionary = {
        abcdefg => 8,
    };

    my $Id = $Board[$i];
    my @SplitPipe = split(/ \| /,$Id);
    my @SplitWords = split(/ /, $SplitPipe[0]);

    for (my $j = 0; $j < 10; $j++) {
        
        my $Word = $SplitWords[$j];
        
        $SplitWords[$j] = join "", sort split //, $Word;
        
        if (length($SplitWords[$j]) == 2) {

            $hDictionary->{$SplitWords[$j]} = 1;
            my @List1 = split //, $SplitWords[$j];

            print ("\r =================Result=================== \r");
            print Dumper @List1;
            print "\r";

        } elsif (length($SplitWords[$j]) == 3) {
            
            $hDictionary->{$SplitWords[$j]} = 7;
            
        } elsif (length($SplitWords[$j]) == 4) {
            
            $hDictionary->{$SplitWords[$j]} = 4;
            
        } elsif (length($SplitWords[$j]) == 5) {
            
            print ("\r =================Result=================== \r");
            print "length 5: $SplitWords[$j] \r";
            
            if (
                (index($SplitWords[$j], $List1[0]) != -1 && index($SplitWords[$j], $List1[1]) == -1) ||
                (index($SplitWords[$j], $List1[1]) != -1 && index($SplitWords[$j], $List1[0]) == -1)
            ) {
                $hDictionary->{$SplitWords[$j]} = 5;
            }
            
        }
    }
    print ("\r =================Result=================== \r");
    print Dumper $hDictionary;
    print "\r";
}

print ("\r =================Result=================== \r");
print "Sum: $Sum \r";



