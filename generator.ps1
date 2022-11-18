############################################################################
#---------- Funkcja sparwdzająca jakość losowań -------------

function Search-Sequential([array]$arr, $item, [switch]$firstfound)
{
    $found=@()

    for($i=0; $i -lt $arr.Length; $i++)
    {
        if($arr[$i].Equals($item) )
        {
            $found+=$i
            if($firstfound)
            {
                return $found
            }
        }
    }
    return $found
}

############################################################################
#---------- Funkcja losująca -------------
Function LosujLiczbe  
{ 
  
  param ( [int]$min , [int]$max ,[int]$inc )
  
  Write-Host "Funkcja inc -----------> $inc"          -ForegroundColor green
  Write-Host "Funkcja historia ------> $historia "    -ForegroundColor green 
  Write-Host "Funkcja losy ----------> $losy "        -ForegroundColor green 
  
  For ($z=0 ; $z -lt 10 ; $z++)
  {
     $losy[$z]=Get-Random -Minimum $min -Maximum $max
      
  }
   
  Write-host "Funkcja 10 kolejka wylosowano" $losy    -ForegroundColor yellow
  
  $los= $losy |Get-Random
  
  Write-host "Funkcja losująca wylosowano->" $los     -ForegroundColor green
  
  $historia[$inc]=$los
  
  Write-Host "Funkcja inc ---------------->" $inc      -ForegroundColor green
  Write-Host "Funkcja historia ----------->" $historia -ForegroundColor green
  
  return $los 
} 

CLS
$losy=@( 0,0,0,0,0,0,0,0,0,0 )
$historia=@(0,0,0,0,0,0,0,0,0,0 )
$inc=-1
For (;;)

{ 

[int]$min=read-host -Prompt "min ?" # Pobranie 1 liczby
[int]$maxi=read-host -Prompt "max ?" # Pobranie 2 liczby
[int]$max=$maxi+1
#-----------------------------------
CLS
Write-Host "Start max -------------> $max"        -ForegroundColor red
Write-Host "Start inc -------------> $inc"        -ForegroundColor red 
Write-Host "Start wylosowano ------> $liczba "    -ForegroundColor red 
Write-Host "Start historia --------> $historia "  -ForegroundColor red
Write-Host "Start losy ------------> $losy "      -ForegroundColor red
$inc++
IF( $max-$min -le 9 ) {$zakres = $max-$min}
ELSE { $zakres=9 }
Write-Host "Start zakres ----------> $zakres"     -ForegroundColor red 
IF( $inc -ge $zakres ) {$inc=0 ; $historia=@( 0,0,0,0,0,0,0,0,0,0 ) }

DO
{
Write-Host "Start inc -------------> $inc"        -ForegroundColor cyan

$liczba=LosujLiczbe $min $max $inc
$sprawdzenie=Search-Sequential -arr $historia -item $liczba
}
UNTIL( $sprawdzenie[1] -eq $null)

Write-Host "Koniec inc -------------> $inc"       -ForegroundColor magenta 
Write-Host "Ostatecznie wylosowano -> $liczba"    -ForegroundColor magenta
Write-Host "Koniec historia --------> $historia"  -ForegroundColor magenta

} 

