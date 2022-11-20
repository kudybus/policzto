############################################################################
#---------- Funkcja losująca cz.a -------------
Function Losuj  
{ 
  
  param ( 
          [int]$min ,
          [int]$max
         )
 
 $ilosclosowan=10
 $losy=@()
    For ($z=0 ; $z -lt $ilosclosowan ; $z++)
    {
        $los=Get-Random -Minimum $min -Maximum $max
        $losy+=$los
    }
 Write-host "Funkcja A 10 kolejka losowania = $losy"    -ForegroundColor green
 $los= $losy |Get-Random
 Write-Host "Funkcja A RETURN los = $los" -ForegroundColor green    
 return $los
}

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
#---------- Funkcja losująca cz.b -------------
Function Losujliczbe  
{ 
  
  param ( 
          [int]$min ,
          [int]$max ,
          $historia
         )

$zakres = $max-$min
Write-Host "Funkcja B zakres ------------------->"$zakres -ForegroundColor cyan
$los=losuj $min $max
$historia+=$los
Write-Host "Funkcja B historia ----------------->"$historia -ForegroundColor cyan
Write-Host "Funkcja B Elementów w tablicy jest = "$historia.Length -ForegroundColor cyan
[int]$index = $historia.Length -1    
Write-Host "Funkcja B index -----> $index" -ForegroundColor cyan
Write-Host "Funkcja B Historia od [$index]=" $historia[$index] -ForegroundColor cyan
#$sprawdz=Search-Sequential -arr $historia -item $los
#Write-Host $sprawdz.length

DO
      { 
        IF( $historia.Length -gt $zakres  ) 
                                    
                                            { 
                                                Write-Host "IF TAK"
                                                $historia=@() 
                                                $historia+=$los
                                                BREAK
                                            }
                
        $sprawdz=Search-Sequential -arr $historia -item $los
        Write-Host "1 Historia $historia"
        Write-Host $sprawdz.length
        IF( $sprawdz.length -gt 1) { 
                                     Write-Host "jeszcze jedno losowanie";
                                     $los=losuj $min $max 
                                     $historia[$index] = $los
                                     Write-Host "2 Historia $historia"
                                   }
             
      }

UNTIL ( $sprawdz.length -eq 1)


                                                    
Write-Host "Funkcja B RETURN historia = $historia" -ForegroundColor cyan       
Write-Host "Funkcja B RETURN los = $los" -ForegroundColor cyan    
return $los ,[array]$historia    

} 

CLS
$historia=@()
For (;;)

{ 

[int]$min=read-host -Prompt "min ?" # Pobranie 1 liczby
[int]$maxi=read-host -Prompt "max ?" # Pobranie 2 liczby
[int]$max=$maxi+1
#-----------------------------------
Write-Host "Start max -------------> $max"        -ForegroundColor red
Write-Host "Start wylosowano ------> $liczba "    -ForegroundColor red 
Write-Host "Start historia --------> $historia "  -ForegroundColor red
$liczba , $historia =Losujliczbe $min $max $historia
#$liczba =LosujLiczbe $min $max
Write-Host "Koniec liczba (los) ----> $liczba"    -ForegroundColor magenta
Write-Host "Koniec historia --------> $historia"  -ForegroundColor magenta
}