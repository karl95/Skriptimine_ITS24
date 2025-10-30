#Autor: kkessel, ITS-24
#puhastan käsurea
Clear-Host

write-Output "**************************************************************"
#Käsureale kuvatakse arvutinime
$arvutinimi=$env:computername
write-Output "See on arvuti nimi: $arvutinimi"
write-Output "**************************************************************"

#Käsureale kuvatakse OS versioon
$os=(Get-CimInstance Win32_OperatingSystem | Select-Object).Caption
write-Output "Operatsioonisüsteem on: $os"
write-Output "**************************************************************"

#Käsureale kuvatakse IPv4 aadress
$ipv4=$ipAddressV4List
write-Output "IPv4 ja Gateway on: $ipv4"
write-Output "**************************************************************"

#Käsureale kuvatakse RAM
$ram=(Get-CimInstance Win32_PhysicalMemory | Measure-Object -Property capacity -Sum).sum /1gb
write-Output "Arvutil on $ram gb Rammi"
write-Output "**************************************************************"

#Käsureale kuvatakse CPU
$cpu=(Get-WmiObject Win32_Processor).Name
write-Output "Prosa on $cpu"
write-Output "**************************************************************"

#Käsureale kuvatakse Videokontroller
$gpu=(Get-WmiObject Win32_VideoController).VideoProcessor
write-Output "Videokontroller on $gpu"
write-Output "**************************************************************"


#Käsureale kuvatakse kõik selle arvuti kasutajad
$kasutajad=(Get-LocalUser).Name
write-Output "Kõik selle arvuti kasutajad: $kasutajad"
write-Output "**************************************************************"