[array]$Global:Board  = @('.','.','.','.','.','.','.','.','.')
[char ]$Global:Player = 'O'
[array]$Global:Score  = @(0,0,0)

function saveBoard
{
    Remove-Item board.txt
    $Board | Out-File board.txt
}

function restoreBoard
{
    [array]$FileBoard = Get-Content board.txt
    $Global:Board = $FileBoard
}

function checkMove
{
    param
    (
        [parameter(Mandatory=$true)][byte]$Position
    )

    if($Global:Board[$Position] -eq '.'){ return $true }
    else { return $false }
}

function makeMove
{
    param
    (
        [parameter(Mandatory=$true)][byte]$Position
    )

    $Global:Board[$Position] = $Player

    if($Global:Player -eq 'X') { $Global:Player = 'O' }
    else { $Global:Player = 'X' }
}

function drawBoard
{
    Write-Host $Global:Board[0]$Global:Board[1]$Global:Board[2]
    Write-Host $Global:Board[3]$Global:Board[4]$Global:Board[5]
    Write-Host $Global:Board[6]$Global:Board[7]$Global:Board[8]
}

function GameOver
{
    if($Global:Board[0] -eq 'X' -and $Global:Board[1] -eq 'X' -and $Global:Board[2] -eq 'X'){ return 0 }
    if($Global:Board[3] -eq 'X' -and $Global:Board[4] -eq 'X' -and $Global:Board[5] -eq 'X'){ return 0 }
    if($Global:Board[6] -eq 'X' -and $Global:Board[7] -eq 'X' -and $Global:Board[8] -eq 'X'){ return 0 }

    if($Global:Board[0] -eq 'X' -and $Global:Board[3] -eq 'X' -and $Global:Board[6] -eq 'X'){ return 0 }
    if($Global:Board[1] -eq 'X' -and $Global:Board[4] -eq 'X' -and $Global:Board[7] -eq 'X'){ return 0 }
    if($Global:Board[2] -eq 'X' -and $Global:Board[5] -eq 'X' -and $Global:Board[8] -eq 'X'){ return 0 }

    if($Global:Board[0] -eq 'X' -and $Global:Board[4] -eq 'X' -and $Global:Board[8] -eq 'X'){ return 0 }
    if($Global:Board[1] -eq 'X' -and $Global:Board[4] -eq 'X' -and $Global:Board[7] -eq 'X'){ return 0 }
    if($Global:Board[2] -eq 'X' -and $Global:Board[4] -eq 'X' -and $Global:Board[6] -eq 'X'){ return 0 }

    if($Global:Board[0] -eq 'O' -and $Global:Board[1] -eq 'O' -and $Global:Board[2] -eq 'O'){ return 1 }
    if($Global:Board[3] -eq 'O' -and $Global:Board[4] -eq 'O' -and $Global:Board[5] -eq 'O'){ return 1 }
    if($Global:Board[6] -eq 'O' -and $Global:Board[7] -eq 'O' -and $Global:Board[8] -eq 'O'){ return 1 }

    if($Global:Board[0] -eq 'O' -and $Global:Board[3] -eq 'O' -and $Global:Board[6] -eq 'O'){ return 1 }
    if($Global:Board[1] -eq 'O' -and $Global:Board[4] -eq 'O' -and $Global:Board[7] -eq 'O'){ return 1 }
    if($Global:Board[2] -eq 'O' -and $Global:Board[5] -eq 'O' -and $Global:Board[8] -eq 'O'){ return 1 }

    if($Global:Board[0] -eq 'O' -and $Global:Board[4] -eq 'O' -and $Global:Board[8] -eq 'O'){ return 1 }
    if($Global:Board[1] -eq 'O' -and $Global:Board[4] -eq 'O' -and $Global:Board[7] -eq 'O'){ return 1 }
    if($Global:Board[2] -eq 'O' -and $Global:Board[4] -eq 'O' -and $Global:Board[6] -eq 'O'){ return 1 }

    $tmp = 0

    foreach($t in $Global:Board)
    {
        if($t -eq '.') { $tmp ++ }
    }
    if($tmp -eq 0){ return 99 }

    return $false
}

saveBoard

$cc = 30
while($cc -ne 0)
{
    $tmp = (0..8) | Get-Random
    if((checkMove -Position $tmp) -ne $false )
    {
        makeMove -Position $tmp
        if((GameOver) -eq 0)
        {
            drawBoard
            restoreBoard
            $Global:Score[0] ++
            Write-Host $Global:Score
        }

        if((GameOver) -eq 1)
        {
            drawBoard
            restoreBoard
            $Global:Score[2] ++
            Write-Host $Global:Score
        }
        if((GameOver) -eq 99 )
        { 
            drawBoard
            restoreBoard
            $Global:Score[1] ++
            Write-Host $Global:Score
        }
    }
    $cc --
}
