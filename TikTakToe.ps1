class GameBoard
{
    [array ]$SBoard
    [array ]$Board
    [array ]$Score  = @(0,0,0)
    [string]$Player = ''
    [string]$Winner = ''
    [array ]$BestPos = @(0,0,0,0,0,0,0,0,0)

    GameBoard($BB)
    {
        $this.SBoard = $BB
    }

    [void]ClearBoard($BS)
    {
        $this.Winner = ''
        $this.Board  = $BS
    }

    [void]InitClass()
    {
        $this.Board  = $this.SBoard
        $this.Player = 'X' #('X','O') | Get-Random
    }

    [void]DrawBoard()
    {
        [byte]$count = 0
        foreach($b in $this.Board)
        {
            Write-Host ($b+" ") -NoNewline
            $count++
            if($count -eq 3){ Write-Host; $count = 0 }
        }
    }

    [void]ReversPlayer()
    {
        if($this.Player -eq 'X'){ $this.Player = 'O' }
        else { $this.Player = 'X' }
    }

    [bool]CheckMove($Position)
    {
        if(($this.Board[$Position]) -eq '.' )
        {
            return $true
        }
        return $false
    }

    [void]MakeMove($Position)
    {
        $this.Board[$Position] = $this.Player
    }

    [int]MoveRest()
    {
        $tmp = 0
        foreach($t in $this.Board)
        {
            if($t -eq '.') { $tmp ++ }
        }
        return $tmp
    }

    [bool]CheckOver()
    {
        if($this.Board[0] -eq 'X' -and $this.Board[1] -eq 'X' -and $this.Board[2] -eq 'X'){ $this.Winner = 'X'; return $true }
        if($this.Board[3] -eq 'X' -and $this.Board[4] -eq 'X' -and $this.Board[5] -eq 'X'){ $this.Winner = 'X'; return $true }
        if($this.Board[6] -eq 'X' -and $this.Board[7] -eq 'X' -and $this.Board[8] -eq 'X'){ $this.Winner = 'X'; return $true }

        if($this.Board[0] -eq 'X' -and $this.Board[3] -eq 'X' -and $this.Board[6] -eq 'X'){ $this.Winner = 'X'; return $true }
        if($this.Board[1] -eq 'X' -and $this.Board[4] -eq 'X' -and $this.Board[7] -eq 'X'){ $this.Winner = 'X'; return $true }
        if($this.Board[2] -eq 'X' -and $this.Board[5] -eq 'X' -and $this.Board[8] -eq 'X'){ $this.Winner = 'X'; return $true }

        if($this.Board[0] -eq 'X' -and $this.Board[4] -eq 'X' -and $this.Board[8] -eq 'X'){ $this.Winner = 'X'; return $true }
        if($this.Board[1] -eq 'X' -and $this.Board[4] -eq 'X' -and $this.Board[7] -eq 'X'){ $this.Winner = 'X'; return $true }
        if($this.Board[2] -eq 'X' -and $this.Board[4] -eq 'X' -and $this.Board[6] -eq 'X'){ $this.Winner = 'X'; return $true }

        if($this.Board[0] -eq 'O' -and $this.Board[1] -eq 'O' -and $this.Board[2] -eq 'O'){ $this.Winner = 'O'; return $true }
        if($this.Board[3] -eq 'O' -and $this.Board[4] -eq 'O' -and $this.Board[5] -eq 'O'){ $this.Winner = 'O'; return $true }
        if($this.Board[6] -eq 'O' -and $this.Board[7] -eq 'O' -and $this.Board[8] -eq 'O'){ $this.Winner = 'O'; return $true }

        if($this.Board[0] -eq 'O' -and $this.Board[3] -eq 'O' -and $this.Board[6] -eq 'O'){ $this.Winner = 'O'; return $true }
        if($this.Board[1] -eq 'O' -and $this.Board[4] -eq 'O' -and $this.Board[7] -eq 'O'){ $this.Winner = 'O'; return $true }
        if($this.Board[2] -eq 'O' -and $this.Board[5] -eq 'O' -and $this.Board[8] -eq 'O'){ $this.Winner = 'O'; return $true }

        if($this.Board[0] -eq 'O' -and $this.Board[4] -eq 'O' -and $this.Board[8] -eq 'O'){ $this.Winner = 'O'; return $true }
        if($this.Board[1] -eq 'O' -and $this.Board[4] -eq 'O' -and $this.Board[7] -eq 'O'){ $this.Winner = 'O'; return $true }
        if($this.Board[2] -eq 'O' -and $this.Board[4] -eq 'O' -and $this.Board[6] -eq 'O'){ $this.Winner = 'O'; return $true }

        return $false
    }
}

[array]$Board1 = @('.','.','.','.','.','.','.','.','.')

$Game = [GameBoard]::new($Board1)
$Game.InitClass()

for($i=0;$i -lt 100;$i++)
{
    while($Game.CheckOver() -ne $true -and $Game.MoveRest() -ne 0)
    {
        [byte]$Move = (0..8) | Get-Random
        if($Game.CheckMove($Move) -ne $false)
        {
            $Game.MakeMove($Move)
            $Game.ReversPlayer()
        }
    }

    if($Game.Winner -eq 'X'){ $Game.Score[2] ++ }
    if($Game.Winner -eq 'O'){ $Game.Score[0] ++ }
    if($Game.Winner -eq '' ){ $Game.Score[1] ++ }

    $Board1 = @('.','.','.','.','.','.','.','.','.')
    $Game.ClearBoard($Board1)
}

Write-Host ("O:"+$Game.Score[0])
Write-Host ("!:"+$Game.Score[1])
Write-Host ("X:"+$Game.Score[2])
$Game.Score = @(0,0,0)

# $Game.DrawBoard()
