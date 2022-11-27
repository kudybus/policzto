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
 Write-host "Funkcja A 10 kolejka losowania = $losy"    -ForegroundColor green
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
          $historia ,
          $los ,
          $kolejka ,
          $i,
          $ilosc,
          $x
         )
Write-Host "PARAM historia" $historia -ForegroundColor cyan
Write-Host "PARAM los" $los -ForegroundColor cyan
Write-Host "PARAM kolejka" $kolejka -ForegroundColor cyan
Write-Host "PARAM i" $i -ForegroundColor cyan
Write-Host "PARAM ilosc" $ilosc -ForegroundColor cyan
Write-Host "PARAM x" $x -ForegroundColor cyan
$zakres = $max-$min

IF( $historia.Length -eq $zakres ){ 
                                    Write-Host "0 IF" -ForegroundColor magenta
                                    $historia=@()
                                  }   
Write-Host "1 IF ilosc=$ilosc and los=$los and i*x=" $i*$x "eq kolejka*ilosc=" $kolejka*$ilosc    -ForegroundColor DarkYellow
IF( $ilosc -eq 2 -and $los -gt 3 -and $i*$x -eq $kolejka*$ilosc )
                            {
                              Write-Host "1 IF" -ForegroundColor cyan
                              return $los ,[array]$historia 
                            }

IF( $historia.Length -lt 1 ){
                              Write-Host "2 IF" -ForegroundColor cyan
                              $los=losuj $min $max
                              $historia+=$los
                              Write-Host "2 IF los $los" -ForegroundColor cyan
                              Write-Host "2 IF Historia $historia" -ForegroundColor cyan
                              Write-Host "2 IF RETURN historia = $historia" -ForegroundColor cyan       
                              Write-Host "2 IF RETURN los = $los" -ForegroundColor cyan    
                              return $los ,[array]$historia 
                            }

IF( $historia.Length -ge 1 -and $historia.Length -lt $zakres )
                            {
                              Write-Host "3 IF" -ForegroundColor yellow
                              $los=losuj $min $max
                              $historia+=$los
                              Write-Host "3 IF los $los" -ForegroundColor yellow
                              Write-Host "3 IF Historia $historia" -ForegroundColor yellow
                              $sprawdz=Search-Sequential -arr $historia -item $los
                              Write-Host "3 IF sprawdz.lenght" $sprawdz.length -ForegroundColor yellow
                              WHILE ( $sprawdz.length -ne 1)
                                 { 
                                   [int]$index = $historia.Length -1
                                   Write-Host "WHILE start - 1.sprawdz.lenght" $sprawdz.length
                                   Write-Host "WHILE index -----> $index"
                                   Write-Host "WHILE 1 Historia $historia"
                                   Write-Host "WHILE jeszcze jedno losowanie" -ForegroundColor red
                                   $los=losuj $min $max
                                   $historia[$index] = $los
                                   Write-Host "WHILE Historia od [$index]=" $historia[$index]
                                   $sprawdz=Search-Sequential -arr $historia -item $los
                                   Write-Host "WHILE 2.sprawdz.lenght" $sprawdz.length
                                   Write-Host "WHILE 2 Historia $historia"
                                 } 
                            }
Write-Host "Funkcja B RETURN los = $los" -ForegroundColor cyan
Write-Host "Funkcja B RETURN historia = $historia" -ForegroundColor cyan       
return $los ,[array]$historia   
}

 CLS
$historia=@()
[int]$kolejka=read-host -Prompt "ilosc przykladów ?" # ilosc przykladów
[int]$ilosc=read-host -Prompt "ilosc skladników ?" # ilosc skladników
[int]$min=read-host -Prompt "min ?" # Pobranie 1 liczby
[int]$maxi=read-host -Prompt "max ?" # Pobranie 2 liczby
[int]$max=$maxi+1
For ($i=1;$i -le $kolejka ; $i++)
{ 
  Write-Host "przykład -----> $i"
  For ($x=1;$x -le $ilosc ; $x++)
{ Write-Host "składnik -----> $x"


#-----------------------------------
Write-Host "Start max -------------> $max"        -ForegroundColor red
Write-Host "Start wylosowano ------> $liczba "    -ForegroundColor red 
Write-Host "Start historia --------> $historia "  -ForegroundColor red
$los , $historia  =Losujliczbe $min $max $historia $los $kolejka $i $ilosc $x
Write-Host "Koniec przykład $i ; składnik $x - wylosowano -> $los "   -ForegroundColor magenta
Write-Host "Koniec historia --------> $historia"  -ForegroundColor magenta
}
}