my @Moves = (
    [0,9,5,9],
    [8,0,0,8],
    [9,4,3,4],
    [2,2,2,1],
    [7,0,7,4],
    [6,4,2,0],
    [0,9,2,9],
    [3,4,1,4],
    [0,0,8,8],
    [5,5,8,2],
);

my @Board = ();

for (my $i = 0; $i < 10; $i++) {
    my @Zeroes = (0) x 10;
    push(@Board, \@Zeroes);
}

for (my $i = 0; $i < scalar @Moves; $i++) {

    if ($Moves[$i][1] != $Moves[$i][3] && $Moves[$i][0] == $Moves[$i][2]) {
        print ("\r found Vertical on $i:  $Moves[$i][1] to $Moves[$i][3]\r");
        $aBoard = markVertical(\@Board, $Moves[$i]);
        @Board = @{$aBoard};
    }

    if ($Moves[$i][0] != $Moves[$i][2] && $Moves[$i][1] == $Moves[$i][3]) {
        print ("\r found Horizontal on $i:  $Moves[$i][0] to $Moves[$i][2]\r");
        $aBoard = markHorizontal(\@Board, $Moves[$i]);
        @Board = @{$aBoard};
    }
    
    if ($Moves[$i][0] != $Moves[$i][2] && $Moves[$i][1] != $Moves[$i][3]) {
        print ("\r found Diagonal on $i:  $Moves[$i][0] to $Moves[$i][2] and $Moves[$i][1] to $Moves[$i][3]\r");
        $aBoard = markDiagonal(\@Board, $Moves[$i]);
        @Board = @{$aBoard};
    }
    
}

use Data::Dumper;
print ("\r =================Result=================== \r");
print Dumper CountBigger2(\@Board);
print ("\r");

#use Data::Dumper;
#print ("\r =================Board=================== \r");
#print Dumper @Board;
#print ("\r");


sub markDiagonal {
    my ($aBoard, $aMoves) = @_;

    $StartY = $aMoves->[1];
    $EndY = $aMoves->[3];

    $StartX = $aMoves->[0];
    $EndX = $aMoves->[2];
    

    my $IsXCorrect = 0;
    my $IsYCorrect = 0;


    my $NewX = $StartX;
    my $NewY = $StartY;

    $aBoard = markBoard($aBoard, $StartX, $StartY);

    until ($IsXCorrect && $IsYCorrect) {

        unless ($IsYCorrect) {

            if ($StartY > $EndY) {
                $NewY -=1;
            } else {
                $NewY +=1;
            }
        }
        
        unless ($IsXCorrect) {

            if ($StartX > $EndX) {
                $NewX -=1;
            } else {
                $NewX +=1;
            }
        }
        
        $aBoard = markBoard($aBoard, $NewX, $NewY);
        
        $IsXCorrect = ($NewX == $EndX) ? 1 : 0;
        $IsYCorrect = ($NewY == $EndY) ? 1 : 0;
    }

    return $aBoard;
}

sub CountBigger2 {
    my ($aBoard) = @_;

    my @Board = @{$aBoard};
    
    my $CountBoardRows = scalar @Board;
    my $CountBoardCols = scalar @{$Board[0]};
    
    my $Res = 0;
    
    for (my $i = 0; $i < $CountBoardRows; $i++) {

        for (my $j = 0; $j < $CountBoardCols; $j++) {

            if ($Board[$i][$j] >= 2) {
                $Res += 1;
            }
        }
    }

    return $Res;
}

sub markVertical {
    my ($aBoard, $aMoves) = @_;

    $Start = $aMoves->[1];
    $End = $aMoves->[3];

    if ($Start > $End) {
        $End = $aMoves->[1];
        $Start = $aMoves->[3];
    }

    for (my $i = $Start; $i <= $End; $i++) {
        $aBoard = markBoard($aBoard, $aMoves->[0], $i);
    }

    return $aBoard;
}

sub markHorizontal {
    my ($aBoard, $aMoves) = @_;

    $Start = $aMoves->[0];
    $End = $aMoves->[2];

    if ($Start > $End) {
        $End = $aMoves->[0];
        $Start = $aMoves->[2];
    }

    for (my $i = $Start; $i <= $End; $i++) {
        $aBoard = markBoard($aBoard, $i, $aMoves->[1]);
    }

    return $aBoard;
}

sub markBoard {
    my ($aBoard, $X, $Y) = @_;

    my @Board = @{$aBoard};

    $Board[$Y][$X] += 1;
    
    print ("\r X: $X and Y: $Y are now $Board[$Y][$X]\r");

    return \@Board;
}


