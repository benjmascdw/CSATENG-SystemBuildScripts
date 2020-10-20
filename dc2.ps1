####
# Purpose: Create DC2 second domain controller
# Author: Ben Mason
#

### Required settings
$domain_name = "csateng.lab"
$hostname = "DC2"
$timezone = "Central Standard Time"
### Network Settings
# set $setipaddress to $true to set IP addressing
$setipaddress = $false  
$network_interface = "Ethernet0"
$ip_Address = "10.89.49.51"
$subnet_mask = "26"
$default_gateway = "10.89.49.1"
$dns_Servers = "10.89.49.50, 10.89.49.51"

$stage_check = Test-Path "c:\stage1complete.txt" -PathType Leaf
if ($stage_check -eq $false) {
    Rename-Computer -NewName $hostname 
    Set-TimeZone -Id $timezone 
    Set-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\Terminal Server' -name "fDenyTSConnections" -value 0
    Enable-NetFirewallRule -DisplayGroup "Remote Desktop"

    if ($setipaddress -eq $true) {
        New-NetIPAddress -InterfaceAlias $network_interface -IPv4Address $ip_Address -PrefixLength $subnet_mask -DefaultGateway $default_gateway
        Set-DnsClientServerAddress -InterfaceAlias $network_interface -ServerAddresses $dns_Servers
    }

    Set-NetConnectionProfile -InterfaceAlias $network_interface -NetworkCategory Private
    New-Item -Path "c:\" -Name "stage1complete.txt" -ItemType "file" -Value "Step one complete."
    Restart-Computer
} else {
    # http://harmikbatth.com/2017/04/25/active-directory-installing-second-or-additional-domain-controller/#page-content
    Install-WindowsFeature -Name AD-Domain-Services –IncludeManagementTools
    Import-module ADDSDeployment
    Remove-Item "c:\stage1complete.txt"

    Install-ADDSDomainController -Credential (Get-Credential) -NoGlobalCatalog:$false -CreateDnsDelegation:$false -CriticalReplicationOnly:$false -DatabasePath "C:\Windows\NTDS" -DomainName $domain_name -InstallDns:$true -LogPath "C:\Windows\NTDS" -NoRebootOnCompletion:$false -SiteName "Default-First-Site-Name" -SysvolPath "C:\Windows\SYSVOL" -Force:$true
}