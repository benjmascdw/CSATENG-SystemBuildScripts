. ./dc1-vars.ps1
# Source: https://github.com/DefensiveOrigins/APT06202001/blob/master/Lab-DomainBuildScripts/ADDS-Step3-Forest.ps1
# create new forest and add domain controller
Import-Module ADDSDeployment
Install-ADDSForest -CreateDnsDelegation:$false -DatabasePath "C:\Windows\NTDS" -DomainMode "WinThreshold" -DomainName $domain_name -DomainNetbiosName $netbiosName -ForestMode "Win2012" -InstallDns:$true -LogPath "C:\Windows\NTDS" -NoRebootOnCompletion:$false -SysvolPath "C:\Windows\SYSVOL" -Force:$true