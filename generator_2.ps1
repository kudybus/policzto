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
  
  For ($z=0 ; $z -lt 10 ; $z++)
    {
     $losy[$z]=Get-Random -Minimum $min -Maximum $max
    }
  $los= $losy |Get-Random
  $historia[$inc]=$los
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
    $inc++
    IF( $max-$min -le 9 ) {$zakres = $max-$min}
    ELSE { $zakres=9 }
    IF( $inc -ge $zakres ) {$inc=0 ; $historia=@( 0,0,0,0,0,0,0,0,0,0 ) }

    DO
    {

        $liczba=LosujLiczbe $min $max $inc
        $sprawdzenie=Search-Sequential -arr $historia -item $liczba
    }
     UNTIL( $sprawdzenie[1] -eq $null)

} 

