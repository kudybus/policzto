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
  $los= $losy |Get-Random
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
$los=losuj $min $max
$historia+=$los
[int]$index = $historia.Length -1    

DO
      { 
        IF( $historia.Length -gt $zakres  ) 
                                    
                                            { 
                                                $historia=@() 
                                                $historia+=$los
                                                BREAK
                                            }
                
        $sprawdz=Search-Sequential -arr $historia -item $los
         IF( $sprawdz.length -gt 1) { 
                                     $los=losuj $min $max 
                                     $historia[$index] = $los
                                    }
             
      }

UNTIL ( $sprawdz.length -eq 1)
                                               
return $los ,[array]$historia    

} 

############################################################################
#---------- Funkcja pobierająca wartść przyciśnietego klawisza -------------

Function PobierzKlawisz
{  
Do
{
    if ([Console]::KeyAvailable)
   {
    $keyInfo = [Console]::ReadKey($true)
    break
   }
    Write-Host `r '? ? ?' -NoNewline -ForegroundColor magenta
    Start-Sleep -MilliSeconds 250
} while ($true)
Return $keyInfo.key
}

############################################################################
#---------- Funkcja pobierająca dane i sprawdzajaca co podano --------------

Function PobierzDane
{ param ($zapytanie)
FOR (;;)
{
$pobrano = Read-Host -Prompt $zapytanie
IF ( $ktorafunkcja -eq 7 ) {
                            $pobrano = $pobrano -replace ",","."
                            $pobrano = $pobrano -replace "[^0-9-.]","" }
ELSE { $pobrano = $pobrano -replace "[^0-9-]","" }                          

IF ( $pobrano -eq "")
    {Write-Host " Nic nie wpisałeś podaj coś" -ForegroundColor Red}
Else
    { Break }
}
Return $pobrano
}

############################################################################
#---------- Funkcja (SILNIK PROGRAMU) --------------------------------------

Function silnik
{ param ( $ktorafunkcja  )
IF ($ktorafunkcja -eq 1) {
                           $tytul="              DODAWANIE"               ;
                           $opis0="Podaj ilość przykładów do rozwiązania" ;
                           $opis1="Podaj ilość składników dodawania"      ;
                           $opis2="Podaj zakres wartości składników"      ;
                           $zapytanie1="ilość przykładów "                ;
                           $zapytanie2="ilość składników dodawania "      ;
                           $zapytanie3="min wartość składnika"            ;
                           $zapytanie4="max wartość składnik"             ;
                         
                         }
IF ($ktorafunkcja -eq 2) {
                           $tytul="              ODEJMOWANIE"             ;
                           $opis0="Podaj ilość przykładów do rozwiązania" ;
                           $opis1="Podaj ilość składników odejmowania"    ;
                           $opis2="Podaj zakres wartości składników"      ;
                           $zapytanie1="ilość przykładów "                ;
                           $zapytanie2="ilość składników odejmowania "    ;
                           $zapytanie3="min wartość odjemnika"            ;
                           $zapytanie4="max wartość odjemnika"            ;
                         }  
IF ($ktorafunkcja -eq 3) {
                           $tytul="               MNOŻENIE"               ;
                           $opis0="Podaj ilość przykładów do rozwiązania" ;
                           $opis1="Podaj ilość składników mnożenia"       ;
                           $opis2="Podaj zakres wartości składników"      ;
                           $zapytanie1="ilość przykładów "                ;
                           $zapytanie2="ilość składników mnożenia "       ;
                           $zapytanie3="min wartość czynnika"             ;
                           $zapytanie4="max wartość czynnika"             ;
                         }
IF ($ktorafunkcja -eq 4) {
                           $tytul="              DZIELENIE"               ;
                           $opis0="Podaj ilość przykładów do rozwiązania" ;
                           $opis1=""                                      ;
                           $opis2="Podaj min i max wartoś dzielników"     ;
                           $zapytanie1="ilość przykładów "                ;
                           $zapytanie2=""                                 ;
                           $zapytanie3="min wartość dzielnika"            ;
                           $zapytanie4="max wartość dzielnika"            ;
                         }
IF ($ktorafunkcja -eq 5) {
                           $tytul="       DZIELENIE PISEMNE ŁATWE"        ;
                           $opis0="Podaj ilość przykładów do rozwiązania" ;
                           $opis1=""                                      ;
                           $opis2="Podaj ilość cyfr dzielnej i dzielnika" ;
                           $zapytanie1="ilość przykładów "                ;
                           $zapytanie2=""                                 ;
                           $zapytanie3="ilość cyfr dzielnej"              ;
                           $zapytanie4="ilość cyfr dzielnika"             ;
                         }
IF ($ktorafunkcja -eq 6) {
                           $tytul="     DZIELENIE PISEMNE ZRESZTĄ"        ;
                           $opis0="Podaj ilość przykładów do rozwiązania" ;
                           $opis1=""                                      ;
                           $opis2="Podaj ilość cyfr dzielnej i dzielnika" ;
                           $zapytanie1="ilość przykładów "                ;
                           $zapytanie2=""                                 ;
                           $zapytanie3="ilość cyfr dzielnej"              ;
                           $zapytanie4="ilość cyfr dzielnika"             ;
                         }
IF ($ktorafunkcja -eq 7) {
                           $tytul="     DZIELENIE PISEMNE TRUDNE"         ;
                           $opis0="Podaj ilość przykładów do rozwiązania" ;
                           $opis1=""                                      ;
                           $opis2=
"Podaj jak ma wyglądać ILORAZ (wynik z dzielenia).
Czyli ile cyfr ma mieć przed i po przecinku
            oraz podaj ilość cyfr dzielnika przez który
            jest dzielona DZIELNA"                                        ;
                           $zapytanie1="ilość przykładów "                ;
                           $zapytanie2=""                                 ;
                           $zapytanie3="ilość cyfr przed przecinkiem"     ;
                           $zapytanie4="ilość cyfr po przecinku"          ;
                           $zapytanie5="ilość cyfr dzielnika"             ;
                         }
CLS
Write-Host $tytul -ForegroundColor magenta
Write-Host "-------------------------------------" -ForegroundColor cyan

#----------------------- PYTANIE O ILOŚĆ PRZYKŁADÓW -----------------------

Write-Host $opis0 -ForegroundColor Yellow
$kolejka = PobierzDane ( $zapytanie1 )
Write-Host

#----------------------- PYTANIE O ILOŚĆ SKŁADNIKÓW -----------------------

IF($ktorafunkcja -le 3)
{
    Write-Host $opis1 -ForegroundColor Yellow
    $ilosc = PobierzDane ( $zapytanie2 )
    Write-Host
}
ELSE
{
    $ilosc = 2
}

#----- PYTANIE I POBRANIE ZAKRESÓW GENEROWANYCH SKŁADNIKÓW DLA MENU OD 1 DO 4 ------

IF($ktorafunkcja -le 4)
{
    Write-Host $opis2 -ForegroundColor yellow
    [int]$min = PobierzDane ( $zapytanie3 )
    [int]$max = PobierzDane ( $zapytanie4 )
    $max+=1
    $minstop =$max-$min
    if ($minstop -lt 0) { $max=$min ; $min+=$minstop }
    Write-Host
}

#--- PYTANIE ILOŚĆ CYFR DZIELNEJ I DZIELNIKA ORAZ ICH POBRANIE DLA MENU OD 5 DO 6 ---

IF ($ktorafunkcja -eq 5 -or $ktorafunkcja -eq 6 )
         {
            Write-Host $opis2 -ForegroundColor yellow
            [int]$cyfrydzielnej  = PobierzDane ( $zapytanie3 )
            [int]$cyfrydzielnika = PobierzDane ( $zapytanie4 )
            $roznica =$cyfrydzielnej-$cyfrydzielnika
            if ($roznica -lt 0) { $cyfrydzielnej=$cyfrydzielnika ; $cyfrydzielnika+=$roznica }
            $min1=1 ; $max1=1 ;
            for ($j=1;$j -le $cyfrydzielnej;$j++)  { $max1*=10 }
            for ($j=1;$j -lt $cyfrydzielnej;$j++)  { $min1*=10 }
            $min2=1 ; $max2=1 ;
            for ($j=1;$j -le $cyfrydzielnika;$j++) { $max2*=10 }
            for ($j=1;$j -lt $cyfrydzielnika;$j++) { $min2*=10 }
            Write-Host
          }

IF ($ktorafunkcja -eq 7  )
         {
            Write-Host $opis2 -ForegroundColor yellow
            [int]$sufix  = PobierzDane ( $zapytanie3 )
            [int]$prefix = PobierzDane ( $zapytanie4 )
            [int]$cyfrydzielnika = PobierzDane ( $zapytanie5 )
                       
            if ($sufix -eq 0 ) { $min1=0 ; $max1=1 ; }    
            ELSE               { $min1=1 ; $max1=1 ; }
            for ($j=1;$j -le $sufix;$j++)  { $max1*=10 }
            for ($j=1;$j -lt $sufix;$j++)  { $min1*=10 }
           
            if ($prefix -eq 0 ) { $min2=0 ; $max2=1 ; }    
            ELSE               { $min2=1 ; $max2=1 ; }
            for ($j=1;$j -le $prefix;$j++) { $max2*=10 }
            for ($j=1;$j -lt $prefix;$j++) { $min2*=10 }
           
            if ($cyfrydzielnika -eq 0 ) { $min3=0 ; $max3=1 ; }    
            ELSE               { $min3=1 ; $max3=1 ; }
            for ($j=1;$j -le $cyfrydzielnika;$j++) { $max3*=10 }
            for ($j=1;$j -lt $cyfrydzielnika;$j++) { $min3*=10 }
            Write-Host
         
          }

#----------- Generowanie Przykładów -------------------------------------------------------------

$historia=@()
for ($i=1;$i -le $kolejka;$i++)
{  
    $czas=0
    $obliczenie=0
    IF ($ktorafunkcja -ge 3) { $obliczenie=1 }
    $liczba = @(0..$ilosc)
    $pytanie="ile to jest "                                                                   # Wstawianie w pytanie tekstu pytania
   
    #------ Generowanie Losowych składników dla MENU od 1 do 4 ----------------------------------
    For($x = 1 ; $x -le $ilosc ; $x++ )                                                       # 
        {                                                                                     # 
            #------ Generowanie Liczb losowych dla MENU od 1 do 4 -------------------------------
            IF ($ktorafunkcja -le 4) {                    
                                          $wynik , $historia =Losujliczbe $min $max $historia # |Generowanie liczb losowych
                                                          $liczba[$x] = $wynik                # |dla poszczególnych składników 
                                                                                              # |dla pojedyńczego przykładu
                                                                      $pytanie += $liczba[$x] # Wstawianie w pytanie liczby
                                     }                                                        #
            #----- Budowanie pytania dla dodawania ----------------------------------------------
            IF ($ktorafunkcja -eq 1) {                                                        #
                                        If ( $x -lt $ilosc ) {$pytanie += " + "}              # Wstawienie w pytanie znak +
                                     }                                                        #
            #----- Budowanie pytania dla odejmowania --------------------------------------------
            IF ($ktorafunkcja -eq 2) {                                                        #                                                        
                                        If ( $x -lt $ilosc ) {$pytanie += " - "}              # Wstawienie w pytanie znak -
                                        If ( $x -gt 1 ) {$liczba[$x] *= -1}                   # Pierwszą liczbę przykładu zamień na dodatnią
                                     }                                                        #
            #----- Budowanie pytania dla mnożenia -----------------------------------------------
            IF ($ktorafunkcja -eq 3) {                                                        #
                                        If ( $x -lt $ilosc ) {$pytanie += " x "}              # Wstawienie w pytanie znak +
                                     }                                                        #
            #------ Wyliczenie wyniku -----------------------------------------------------------
            IF ($ktorafunkcja -le 2) { $obliczenie +=$liczba[$x] }                            # Wyliczenie wyniku dla dodawania i odejmowania
            IF ($ktorafunkcja -eq 3) { $obliczenie *=$liczba[$x] }                            # Wyliczenie wyniku dla mnożenia
        }                                                                                     #
#================================================== MODUŁ DZIELENIA ========================================================    

    #----- Dzielenie Pamięciowe -------------------------------------
    IF ($ktorafunkcja -eq 4)                                      # Jeżeli dzielenie pamięciowe wykonaj
        {                                                         #
            $dzielna=$liczba[1]*$liczba[2]                        # Wyliczenie dzielnej na podstawie wylosowanych dzielników
            $dzielnik=$liczba[2]                                  # Dzielnik to druga wygenerowana liczba
            $pytanie="ile to jest $dzielna : $dzielnik"           # Przygotowanie pytania
            $obliczenie=$dzielna/$dzielnik                        # Przygotowanie wyniku
        }                                                         #
    #----- Generowanie Dzielnej i Dzielnika dla MENU od 5 do 6 ------
    IF ($ktorafunkcja -eq 5 -or $ktorafunkcja -eq 6)              # Jeżeli dzielenie z MENU od 5 do 6 wykonaj
          {                                                       #
            $dzielna =  LosujLiczbe $min1 $max1                   # Losuj dzielną
            $dzielnik = LosujLiczbe $min2 $max2                   # Losuj dzielnik
            WHILE( $dzielnik -eq 1 )                              #
                 { $dzielnik = LosujLiczbe $min2 $max2 }          #
            $modulo=$dzielna%$dzielnik                            # Reszta z dzielenia dzielna/dzielnik
          }                                                       #
    #----- Dzielenie Łatwe ( Bez Reszty ) dla MENU 5 ----------------
    IF ($ktorafunkcja -eq 5)                                      # Jeżeli dzielenie łatwe wykonaj
          {                                                       #
            $dzielna -=$modulo                                    # Odjęcie od dzielnej reszty z dzielenia
            WHILE ($dzielna -lt $min1) { $dzielna+=$dzielnik }    # Dopuki dzielna jest mniejsza od wylosowanej dzielnej dodawaj do niej dzielnik
            $pytanie="ile to jest $dzielna : $dzielnik"           # Przygotowanie pytania
            $obliczenie=$dzielna/$dzielnik                        # Przygotowanie wyniku
          }                                                       #
    #----- Dzielenie z Resztą dla MENU 6 -----------------------------    
    IF ($ktorafunkcja -eq 6)                                      # Sprawdzenie czy wybrano dzielenie z resztą
          {                                                       #
            $pytanie="ile to jest $dzielna : $dzielnik"           # Przygotowanie pytania
            $obliczenie=$dzielna/$dzielnik                        # Przygotowanie wyniku
            $obliczenie=[int][Math]::floor($obliczenie)           # Zaokrąglenie wyniku w dół bez części ułamkowej
            [string]$obliczenie="$obliczenie $modulo"             # Dodanie do wyniku reszty z dzielenia
          }                                                       #
   
    #----- Generowanie Dzielnej i Dzielnika dla MENU 7 --------------
    IF ($ktorafunkcja -eq 7)                                      # Jeżeli dzielenie z MENU od 5 do 6 wykonaj
          {                                                       #
            $sufix =  LosujLiczbe $min1 $max1                     # Losuj sufix
            $prefix = LosujLiczbe $min2 $max2                     # Losuj prefix
            $prefix1 = $prefix/$max2                              # Prefix zamieniony na ułamek dziesiętny
            $iloraz = $sufix+$prefix1                             # Utworzenie ilorazu
            $dzielnik = LosujLiczbe $min3 $max3                   # Losuj dzielnik
            $dzielna = $dzielnik * $iloraz                        # Dzielna = dzielnik * iloraz
            $pytanie="ile to jest $dzielna : $dzielnik"           # Przygotowanie pytania
            $obliczenie=$iloraz                                   # Przygotowanie wyniku
          }                                                       #    
    #------ Wyświetlanie Pytań ( Przykłaów ) ------------------------
    Write-Host $i" - Przykład" -ForegroundColor magenta           # Wydruk numeru kolejni
    Write-Host $pytanie -ForegroundColor cyan                     # Wydruk pytania
    #----------------------------------------------------------------
    $czas=sprawdzenie($obliczenie)                                # Wywołanie funkcji sprawdzającej poprawność odpowiedzi i zmierzenie czasu odpowiedzi
    $sekundy += [int]$czas                                        # Zsumowanie czasów odpowiedzi z wszystkich wygenerowanych przykładów
}                                                                 #
#--------------------------------------------------------------------
 
 IF( $sekundy -gt 59 )
     {
         $minuty=[int][Math]::floor($sekundy / 60)
         $reszta=$sekundy % 60
         [string]$min=$minuty
         [string]$sek=$reszta
     }
 ELSE
     {
        [string]$min=0;
        [string]$sek=$sekundy
     }
Write-Host "Całkowity czas rozwiazania to "$min.Padleft(2,'0')"m :"$sek.padleft(2,"0")"s" -ForegroundColor cyan
Write-Host
Write-Host "Czy chcesz liczyć Dalej ?" -ForegroundColor yellow
Write-Host "TAK --- naciśnij jakiś klawisz" -ForegroundColor green
Write-Host "NIE --- naciśnij klawisz "-ForegroundColor green -NoNewline ; Write-Host  "[ N ]" -ForegroundColor red
$klawisz = PobierzKlawisz
IF ($klawisz -eq 'N') { CLS ; Write-host ; Write-host "                        Dziękuję i do następnego razu :)"-ForegroundColor magenta ; start-sleep 3 ; EXIT }
}


#############################################################################################
#----- Funkcja sprawdzajaca poprawność odpowiedzi na pytanie i mierząca czas odpowiedzi -----

Function sprawdzenie
{ param (
          $obliczenie
        )
$stoper.Restart()
DO
{
     If ($ktorafunkcja -eq 6) {
                                $wynik =  PobierzDane ( "?")
                                $reszty = PobierzDane ( "reszta")
                                [string]$wynik="$wynik $reszty"
                              }  
     ELSE { $wynik = PobierzDane ( "?") }
           
        If ($wynik -eq $obliczenie)
        {

            $stoper.stop();
            [int]$sekundy=$stoper.Elapsed.TotalSeconds
            IF ($sekundy -gt 59 )
                {
                 $minuty=[int][Math]::floor($sekundy / 60);
                 $reszta=$sekundy % 60;
                 [string]$min=$minuty;
                 [string]$sek=$reszta;
                }
            ELSE
                {
                [string]$min=0;
                [string]$sek=$sekundy
                }
           
            Write-Host "Dobry wynik Brawo!"    -ForegroundColor Green ;
            Write-Host "Czas rozwiazania to "$min.Padleft(2,'0')"m :"$sek.padleft(2,"0")"s" -ForegroundColor yellow
            Write-Host
        }
        Else
        {
            Write-Host "Zły wynik Popraw się!" -ForegroundColor Red ;
            Write-Host
        }

}
UNTIL ( $wynik -eq $obliczenie )
Return $sekundy
}

############################################################
#----- Początek Programu -----------------------------------
[string]$a=Get-Item .
$sciezka=$a -replace "\\","_"
$sciezka=$sciezka+"_policzto.exe"
$sciezka=$sciezka -replace "__","_"
$test=Test-Path HKCU:\Console\$sciezka
IF ($test) { }
ELSE
           {  
              New-Item -Path Registry::HKEY_CURRENT_USER\Console\ -Name $sciezka
              New-ItemProperty -Path Registry::HKEY_CURRENT_USER\Console\$sciezka\ -Name CursorType -PropertyType dword -Value 0x00000000
              New-ItemProperty -Path Registry::HKEY_CURRENT_USER\Console\$sciezka\ -Name FaceName -PropertyType string -Value Consolas
              New-ItemProperty -Path Registry::HKEY_CURRENT_USER\Console\$sciezka\ -Name FontFamily -PropertyType dword -Value 0x00000036
              New-ItemProperty -Path Registry::HKEY_CURRENT_USER\Console\$sciezka\ -Name FontSize -PropertyType dword -Value 0x00180000
              New-ItemProperty -Path Registry::HKEY_CURRENT_USER\Console\$sciezka\ -Name FontWeight -PropertyType dword -Value 0x00000190
              New-ItemProperty -Path Registry::HKEY_CURRENT_USER\Console\$sciezka\ -Name InterceptCopyPaste -PropertyType dword -Value 0x00000000
              New-ItemProperty -Path Registry::HKEY_CURRENT_USER\Console\$sciezka\ -Name ScreenBufferSize -PropertyType dword -Value 0x23290050
              New-ItemProperty -Path Registry::HKEY_CURRENT_USER\Console\$sciezka\ -Name WindowPosition -PropertyType dword -Value 0x00000000
              New-ItemProperty -Path Registry::HKEY_CURRENT_USER\Console\$sciezka\ -Name WindowSize -PropertyType dword -Value 0x00280050 
              Start-Process $a\policzto.exe
              EXIT
           }

######################################################################
#----- MENU ----------------------------------------------------------

$rand = New-Object System.Random
$stoper = [System.Diagnostics.Stopwatch]::new()
FOR (;;)
{
CLS
Write-Host "         -------------------------------------------------------------" -ForegroundColor green
Write-Host "         | Dodawanie                  --> Naciśnij klawisz " -ForegroundColor green -NoNewline ; Write-Host "--> [ 1 ]"-ForegroundColor red -NoNewline ; Write-Host " |" -ForegroundColor green
Write-Host "         | Odejmowanie                --> Naciśnij klawisz " -ForegroundColor green -NoNewline ; Write-Host "--> [ 2 ]"-ForegroundColor red -NoNewline ; Write-Host " |" -ForegroundColor green
Write-Host "         | Mnożenie                   --> Naciśnij klawisz " -ForegroundColor green -NoNewline ; Write-Host "--> [ 3 ]"-ForegroundColor red -NoNewline ; Write-Host " |" -ForegroundColor green
Write-Host "         | Dzielenie pamięciowe       --> Naciśnij klawisz " -ForegroundColor green -NoNewline ; Write-Host "--> [ 4 ]"-ForegroundColor red -NoNewline ; Write-Host " |" -ForegroundColor green
Write-Host "         | Dzielenie pisemne łatwe    --> Naciśnij klawisz " -ForegroundColor green -NoNewline ; Write-Host "--> [ 5 ]"-ForegroundColor red -NoNewline ; Write-Host " |" -ForegroundColor green
Write-Host "         | Dzielenie pisemne z resztą --> Naciśnij klawisz " -ForegroundColor green -NoNewline ; Write-Host "--> [ 6 ]"-ForegroundColor red -NoNewline ; Write-Host " |" -ForegroundColor green
Write-Host "         | Dzielenie pisemne trudne   --> Naciśnij klawisz " -ForegroundColor green -NoNewline ; Write-Host "--> [ 7 ]"-ForegroundColor red -NoNewline ; Write-Host " |" -ForegroundColor green
Write-Host "         -------------------------------------------------------------"-ForegroundColor green
Write-Host "         | Zakończ program            --- Naciśnij klawisz " -ForegroundColor green -NoNewline ; Write-Host "[ ENTER ]"-ForegroundColor red -NoNewline ; Write-Host " |" -ForegroundColor green
Write-Host "         -------------------------------------------------------------" -ForegroundColor green
$klawisz = PobierzKlawisz
Write-Host
IF ($klawisz -eq 'D1')    { silnik (1) }
IF ($klawisz -eq 'D2')    { silnik (2) }
IF ($klawisz -eq 'D3')    { silnik (3) }
IF ($klawisz -eq 'D4')    { silnik (4) }
IF ($klawisz -eq 'D5')    { silnik (5) }
IF ($klawisz -eq 'D6')    { silnik (6) }
IF ($klawisz -eq 'D7')    { silnik (7) }
IF ($klawisz -eq 'ENTER') { Write-host ; Write-host "                        Dziękuję i do następnego razu :)"-ForegroundColor magenta ; start-sleep 3 ; EXIT }
}
