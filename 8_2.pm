use Data::Dumper;

my @Board = (
    'acedgfb cdfbe gcdfa fbcad dab cefabd cdfgeb eafb cagedb ab | cdfeb fcadb cdfeb cdbaf',
'cfgda fdebgc bfcdeag dbg afgedb efbad bg cdfeab gabdf abeg | dbg fbedgca gbea gbae',
'defgca efgbadc ecgba gecbfd db dabegf aebdg gdfae deb adfb | dcgaef edb bed becgdfa',
);

my $aDictionary = ['1','7','4','8'];

my $aDictionary = ['cf','bcdf','acf','abcdefg'];

my $bar = 'abdfg';


# acdeg => 2
# acdfg => 3
# abdfg => 5

# abdefg => 6
# abcdfg => 9
# abcefg => 0


my $aDictionaryCount = [2,3,4,7];

my $CountBoard = scalar @Board;


my $hWordDictionary = getWordDictionary($Board[0]);

my $hNumberDictionary;

foreach $Word (keys %{$hWordDictionary}) {
  my $Number = $hWordDictionary->{$Word};
  $hNumberDictionary->{$Number} = $Word;
}


$hNumberDictionary->{5} = getWord($Board[0], $hNumberDictionary->{1}, 5);

$hNumberDictionary->{5} = getWord($Board[0], $hNumberDictionary->{1}, 5);



print ("\r =================Result=================== \r");
print Dumper $hNumberDictionary;
print "\r";

print ("\r =================Result=================== \r");
print Dumper $hWordDictionary;
print "\r";


sub getWord {
    my ($BoardLine, $WordToFind, $Length) = @_;
    
    my @SplitWordToFind = split(/ \| /, $WordToFind);
    
    my @SplitPipe = split(/ \| /, $BoardLine);
    my @SplitWords = split(/ /, $SplitPipe[0]);
    
    
    for (my $j = 0; $j < 10; $j++) {
        
        my $Word = $SplitWords[$j];
        
        $SplitWords[$j] = join "", sort split //, $Word;
        
        if (length($SplitWords[$j]) == $Length) {
            
            for (my $k = 0; $k < scalar @SplitWordToFind; $k++) {
                
                if (index($SplitWords[$j], $SplitWordToFind[$k]) == -1) {
                    return $SplitWords[$j];
                }
            }
            
        }
    }

    return undef;
}


sub getWordDictionary {
    my ($BoardLine) = @_;

        my $hDictionary = {
            abcdefg => 8,
        };

        my @SplitPipe = split(/ \| /, $BoardLine);
        my @SplitWords = split(/ /, $SplitPipe[0]);

        for (my $j = 0; $j < 10; $j++) {
        
            my $Word = $SplitWords[$j];
        
            $SplitWords[$j] = join "", sort split //, $Word;
        
            if (length($SplitWords[$j]) == 2) {

                $hDictionary->{$SplitWords[$j]} = 1;
                my @List1 = split //, $SplitWords[$j];

                
            } elsif (length($SplitWords[$j]) == 3) {
            
                $hDictionary->{$SplitWords[$j]} = 7;
            
            } elsif (length($SplitWords[$j]) == 4) {
            
                $hDictionary->{$SplitWords[$j]} = 4;
            
            }
        }
        
    return $hDictionary;
}





