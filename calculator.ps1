# Ask the user to input a number using the given prompt string
function Get-Double {

    param (
        $Prompt   
    )
    
    do {
        $inp = Read-Host -Prompt $Prompt

        # Try to cast, if that fails $num will contain null
        $num = $inp -as [Double]
        $ok = $num -ne $NULL
        if (-not $ok) { 
            Write-Host "You must enter a numeric value" -ForegroundColor Red
        }
    # try until the user gets it right
    } until ($ok)

    return $num
}

# Do a exponentiation using the given base and exponent
function Calculate-Exponent {

    param (
        $Base,
        $Exp
    )
    
    $res = 1

    # If the exponent is < 0, flip the sign of it to allow the same loop to be used
    # Also use the inverse base in that case since x/y = x*(1/y)
    if ($Exp -lt 0) {
        $Base = 1/$Base;
        $Exp *= -1;
    }

    for ($i = 0; $i -lt $Exp; $i++) {
        $res *= $Base
    }

    return $res
}
    
while (1) {
    clear
    Write-Host "PowerShell CLI Calculator Created by naren_gavli" -ForegroundColor Yellow
    Write-Host "Choose a function"
    Write-Host "1 - Add         2 - Subtract              3 - Multiply"
    Write-Host "4 - Divide      5 - Exponentiation        6 - Modulo"
    
    do {
        # The Read-Host cmdlet puts a ":" after the supplied prompt when using -Prompt.
        # If we do it like this, we can get the requested custom prompt without that
        Write-Host -nonewline ">>> "
        $mode = Read-Host

        #match a single 1 2 3 4 5 or 6
        $ok = $mode -match "^[1-6]$"
    
        if (-not $ok) {
            Write-Host "Please enter a number between 1 and 5" -ForegroundColor Red
        }
    
    } until ($ok)
    
    # Newline for formatting
    Write-Host ""
    
    # Array definitions so that we can use the inputted mode value easily
    $modes = @("Addition", "Subtraction", "Multiplication", "Division", "Exponentation", "Modulo")
    $signs = @("+", "-", "*", "/", "^","%")
    
    Write-Host $("{0} - Please choose two numbers a and b to calculate a {1} b" -f $modes[$mode-1], $signs[$mode-1])
    
    $a = Get-Double -Prompt "a"
    $b = Get-Double -Prompt "b"

    switch ($mode) {
        1 {$res = $a + $b; break}
        2 {$res = $a - $b; break}
        3 {$res = $a * $b; break}
        4 {$res = $a / $b; break}
        5 {$res = Calculate-Exponent -Base $a -Exp $b; break}
        6 {$res = $a % $b; break}
    }

    Write-Host $("Result: {0} {1} {2} = {3}" -f $a, $signs[$mode-1], $b, $res)
    Write-Host ""

    Write-Host "Type Q/q to quit or press Enter to restart"
    do {
        Write-Host -NoNewline ">>> "
        $inp = $NULL
        $inp = Read-Host

        # Match a single q or Q
        if ($inp -match "^[qQ]$") {
            exit;
        }

        # Pressing enter results in the input being of length 0
        $ok = $inp.Length -eq 0
        if (-not $ok) {
            Write-Host "Please type either Q/q to quit or press Enter to restart!" -ForegroundColor Red
        }
    } until($ok); 
}