$Url1="https://www.dropbox.com/s/wqcmufws707389b/download_xampp.ps1?dl=1"
Invoke-WebRequest $Url1 -OutFile C:\download_xampp.ps1
$Url2="https://www.dropbox.com/s/fivoof79xprt18u/exec_xampp.ps1?dl=1"
Invoke-WebRequest $Url2 -OutFile C:\exec_xampp.ps1
$Url3="https://www.dropbox.com/s/ysemctpyjxyjuwb/set_firewall.ps1?dl=1"
Invoke-WebRequest $Url3 -OutFile C:\set_firewall.ps1