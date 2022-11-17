 
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
  CLS
  Write-Host "Funkcja inc ---> "$inc -ForegroundColor red
  Write-Host "Funkcja historia ------> $historia " -ForegroundColor green 
  Write-Host "Funkcja losy ------> $losy " -ForegroundColor green 
  
  For ($z=0 ; $z -lt 10 ; $z++)
  {
     $losy[$z]=Get-Random -Minimum $min -Maximum $max
     Write-host $z" kolejka wylosowano" $losy -ForegroundColor yellow 
  }
   # IF ( $losy[$z] -eq $losy[$z-1] )             { $losy[$z]=Get-Random -Minimum $min -Maximum $max }
   # IF ( $z -gt 1 -and $losy[$z] -eq $losy[$z-2] ) { $losy[$z]=Get-Random -Minimum $min -Maximum $max }
   # IF ( $z -gt 2 -and $losy[$z] -eq $losy[$z-3] ) { $losy[$z]=Get-Random -Minimum $min -Maximum $max }
   $los= $losy |Get-Random
   Write-host "funkcja losująca wylosowano-->"$los -ForegroundColor red
   $historia[$inc]=$los
   Write-Host "Funkcja inc ---> "$inc -ForegroundColor red
   return $los 
} 

CLS
$losy=@( 0,0,0,0,0,0,0,0,0,0 )
$historia=@(0,0,0,0,0,0,0,0,0,0 )
$inc=-1
Write-Host "losy ------> $losy " -ForegroundColor cyan
For (;;)

{ 

$min=read-host -Prompt "min ?" # Pobranie 1 liczby
$max=read-host -Prompt "max ?" # Pobranie 2 liczby
#-----------------------------------
Write-Host "inc "$inc -ForegroundColor red 
Write-Host "wylosowano ----> $liczba " -ForegroundColor red 
Write-Host "historia ------> $historia " -ForegroundColor green
Write-Host "losy ------> $losy " -ForegroundColor cyan
$inc++
IF( $inc -gt 9) {$inc=0 ; $losy=@( 0,0,0,0,0,0,0,0,0,0 ) }
Do
{
Write-Host "inc "$inc -ForegroundColor red 
$liczba=LosujLiczbe $min $max $inc
$sprawdzenie=Search-Sequential -arr $historia -item $liczba
}
UNTIL( $sprawdzenie[1] -eq $null)

Write-Host "inc "$inc -ForegroundColor red 
 
Write-Host "inc "$inc -ForegroundColor red 
#$historia[$inc]=$liczba
Write-Host "Ostatecznie wylosowano $liczba" -ForegroundColor red
Write-Host "historia" $historia -ForegroundColor cyan
}