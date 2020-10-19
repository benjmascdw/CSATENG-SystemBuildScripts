####
# Purpose: Add Active Directory related Windows Features
# Second Step in Labnet Domain Controller Build
# Author: Ben Mason
#

. ./dc1-vars.ps1

# Reset DNS Servers from any temporary settings
Set-DnsClientServerAddress -InterfaceAlias $network_interface -ServerAddresses $dns_servers

# Install Features 
$addsTools = "RSAT-AD-Tools" 
Add-WindowsFeature $addsTools 
Add-WindowsFeature -Name "ad-domain-services" -IncludeAllSubFeature -IncludeManagementTools 
Add-WindowsFeature -Name "dns" -IncludeAllSubFeature -IncludeManagementTools 
Add-WindowsFeature -Name "gpmc" -IncludeAllSubFeature -IncludeManagementTools
Add-WindowsFeature -Name "AD-Certificate" -IncludeAllSubFeature -IncludeManagementTools

# Source: https://github.com/DefensiveOrigins/APT06202001/blob/master/Lab-DomainBuildScripts/ADDS-Step3-Forest.ps1
# create new forest and add domain controller
Import-Module ADDSDeployment
Install-ADDSForest -CreateDnsDelegation:$false -DatabasePath "C:\Windows\NTDS" -DomainMode "WinThreshold" -DomainName $domain_name -DomainNetbiosName $netbiosName -ForestMode "Win2012" -InstallDns:$true -LogPath "C:\Windows\NTDS" -NoRebootOnCompletion:$false -SysvolPath "C:\Windows\SYSVOL" -Force:$true
