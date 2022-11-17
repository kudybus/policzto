$losy=@( 0,0,0,0,0,0,0,0,0,0 )
$historia=@(0,0,0,0,0,0,0,0,0,0 )
$inc=-1 

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
#---------- Funkcja pobierająca wartść przyciśnietego klawisza -------------
Function LosujLiczbe  
{ 
  param ( [int]$min , [int]$max  )
  
   #$losy=@( 0,0,0,0,0,0,0,0,0,0 )
   
  Write-host $los
  For ($z=0 ; $z -lt 10 ; $z++)
  {
    $losy[$z]=Get-Random -Minimum $min -Maximum $max
    Write-host $z" kolejka wylosowano" $losy   }
  
  Write-host $losy
  $los= $losy |Get-Random
  Write-host $los
   
  return $los 
} 

For (;;)

{ 

$min=read-host -Prompt "min ?"
$max=read-host -Prompt "max ?"
$liczba=LosujLiczbe $min $max
Write-Host "wylosowano ----> $liczba" 
Write-Host "historia" $historia
$inc++
Write-Host " inc "$inc
IF( $inc -gt 9) {$inc=0}
$historia[$inc]=$liczba
Write-Host "wylosowano $liczba" 
Write-Host "losy" $losy
Do
{
$liczba=LosujLiczbe $min $max
$aaa=Search-Sequential -arr $historia -item $liczba
Write-Host "aaa0 " $aaa[0] "aaa1 " $aaa[1] 
}
UNTIL( $aaa[1] -eq $null) 
$historia[$inc]=$liczba
Write-Host "nie znaleziono"
Write-Host "Ostatecznie wylosowano $liczba"
Write-Host "historia" $historia
}
