$ipv4=(Get-NetIPAddress -AddressFamily IPv4 -InterfaceIndex $(Get-NetConnectionProfile | Select-Object -ExpandProperty InterfaceIndex) | Select-Object -ExpandProperty IPAddress)
Set-DNSClientServerAddress –InterfaceIndex (Get-NetAdapter).InterfaceIndex –ServerAddresses ($ipv4,"8.8.8.8")
Install-WindowsFeature -name AD-Domain-Services -IncludeManagementTools
$Secure_String_Pwd = ConvertTo-SecureString "P@ssw0rd123" -AsPlainText -Force
Install-ADDSForest -DomainName abc.com -InstallDNS -SafeModeAdministratorPassword $Secure_String_Pwd -Force
