my @DrawnNumbers = (7,4,9,5,11,17,23,2,0,14,21,24,10,16,13,6,15,25,12,22,18,20,8,19,3,26,1);

my @Boards = (
[22,13,17,11,0],
[8,2,23,4,24],
[21,9,14,16,7],
[6,10,3,18,5],
[1,12,20,15,19],
[3,15,0,2,22],
[9,18,13,17,5],
[19,8,7,25,23],
[20,11,10,24,4],
[14,21,16,12,6],
[14,21,17,24,4],
[10,16,15,9,19],
[18,8,23,26,20],
[22,11,13,6,5],
[2,0,12,3,7],
);

my $CountBoards = (scalar @Boards) / 5;
print ("\r ==============CountBoards====================== \r");
print ("\r $CountBoards  \r");

my $CountNumbers = (scalar @DrawnNumbers);

my $hLineBingo;
my $hColumnBingo;
my $CurrentNumber = 0;

for (my $i = 0; $i < $CountNumbers; $i++ ) {

    $CurrentNumber = $DrawnNumbers[$i];

    my @Boards = markNumberOnBoards(\@Boards, $DrawnNumbers[$i]);

    $hLineBingo = checkLineBingo(\@Boards);

    if ($hLineBingo->{'hasBingo'}) {
        print ("\r Line Bingo found on Card: " . $hLineBingo->{'cardBingo'} . "\r");
        last;
    }
    
    $hColumnBingo = checkColumnBingo(\@Boards);

    if ($hColumnBingo->{'hasBingo'}) {
        print ("\r Column Bingo found on Card: " . $hColumnBingo->{'cardBingo'} . "\r");
        last;
    }
}

use Data::Dumper;
print ("\r ==============LineBingo====================== \r");
print Dumper $hLineBingo;
print ("\r");


use Data::Dumper;
print ("\r ===============ColumnBingo===================== \r");
print Dumper $hColumnBingo;
print ("\r");


print ("\r =================Result SUM=================== \r");
print (getBoardSum(\@Boards, 2) * $CurrentNumber);
print ("\r");


use Data::Dumper;
print ("\r =================Boards=================== \r");
print Dumper @Boards;
print ("\r");



sub checkColumnBingo {
    my ($aBoards) = @_;

    my @Boards = @{$aBoards};
    my $CountRows = (scalar @Boards);

    my $hResult = {
        hasBingo => 0,
        cardBingo => 0,
    };

    my $HasBingo = 0;
    my $CountBoards = (scalar @Boards) / 5;

    for (my $i = 0; $i < $CountBoards; $i++ ) {

        my $aBoard = getBoard(\@Boards, $i);
        
        my @Board = @{$aBoard};
        

        for (my $cols = 0; $cols < 5; $cols++ ) {
            $HasBingo = 1;
            for (my $lines = 0; $lines < 5; $lines++ ) {

                #print ("\r ==============Lookin checkColumnBingo====================== \r");
                #print ("\r" . $Board[$lines][$cols] . "\r");

                if ($Board[$lines][$cols] != 888) {
                    $HasBingo = 0;
                    last;
                }
            }
            if ($HasBingo) {
                $hResult->{'hasBingo'} = $HasBingo;
                $hResult->{'cardBingo'} = $i;
                return $hResult;
            }
        }
    }
    return $hResult;
}

sub checkLineBingo {
    my ($Boards) = @_;

    my @Boards = @{$Boards};
    my $CountRows = (scalar @Boards);

    my $CountBoards = (scalar @Boards) / 5;

    my $hResult = {
        hasBingo => 0,
        lineBingo => 0,
        cardBingo => 0,
    };
    my $HasBingo;

    for (my $i = 0; $i < $CountRows; $i++ ) {
        $HasBingo = 1;
        for (my $j = 0; $j < 5; $j++ ) {

            #print ("\r ==============Lookin checkLineBingo====================== \r");
            #print ("\r" . $Boards[$i][$j] . "\r");

            if ($Boards[$i][$j] != 888) {
                $HasBingo = 0;
                last;
            }
        }
        if ($HasBingo) {
            $hResult->{'hasBingo'} = $HasBingo;
            $hResult->{'lineBingo'} = $i;
            $hResult->{'cardBingo'} = $i / 5;
            return $hResult;
        }
    }
    return $hResult;
}

sub getBoard {
    my ($Boards, $Index) = @_;

    my @Boards = @{$Boards};

    $Index += 1;

    #print ("\r Index: $Index  \r");

    my $End = $Index * 5;
    #print ("\r End: $End  \r");
    my $Start = $End - 5;
    #print ("\r Start: $Start  \r");

    my @Result;

    for (my $i = $Start; $i < $End; $i++ ) {
        push(@Result, @Boards[$i]);
    }
    
    return \@Result;
}

sub getBoardSum {
    my ($Boards, $Index) = @_;

    $Index += 1;

    my @Boards = @{$Boards};

    my $End = $Index * 5;
    #print ("\r End: $End  \r");
    my $Start = $End - 5;
    #print ("\r Start: $Start  \r");

    my $Result = 0;

    for (my $i = $Start; $i < $End; $i++ ) {
        for (my $j = 0; $j < 5; $j++ ) {
            $Result += ($Boards[$i][$j] == 888) ? 0 : $Boards[$i][$j];
        }
    }
    
    return $Result;
}

sub markNumberOnBoards {
    my ($Boards, $Number) = @_;

    my @Boards = @{$Boards};
    my $CountRows = (scalar @Boards);

    my @Result;

    for (my $i = 0; $i < $CountRows; $i++ ) {
        for (my $j = 0; $j < 5; $j++ ) {
            if ($Boards[$i][$j] == $Number) {
                $Boards[$i][$j] = 888;
            }
        }
    }
    return @Boards;
}

