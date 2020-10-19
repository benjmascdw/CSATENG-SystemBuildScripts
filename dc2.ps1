$domain_name = "csateng.lab"
$hostname = "DC2"
$network_interface = "Ethernet0"
$ip_Address = "10.89.49.51"
$subnet_mask = "26"
$default_gateway = "10.89.49.1"
$dns_Servers = "10.89.49.50, 10.89.49.51"
$timezone = "Central Standard Time"

Rename-Computer -NewName $hostname 
# Set timezone
Set-TimeZone -Id $timezone 
Set-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\Terminal Server' -name "fDenyTSConnections" -value 0
Enable-NetFirewallRule -DisplayGroup "Remote Desktop"
New-NetIPAddress –InterfaceAlias $network_interface –IPv4Address $ip_Address –PrefixLength $subnet_mask -DefaultGateway $default_gateway
Set-DnsClientServerAddress -InterfaceAlias $network_interface -ServerAddresses $dns_Servers
Set-NetConnectionProfile -InterfaceAlias $network_interface -NetworkCategory Private

Restart-Computer

# http://harmikbatth.com/2017/04/25/active-directory-installing-second-or-additional-domain-controller/#page-content
Install-WindowsFeature -Name AD-Domain-Services –IncludeManagementTools
Import-module ADDSDeployment

Install-ADDSDomainController -NoGlobalCatalog:$false -CreateDnsDelegation:$false -CriticalReplicationOnly:$false -DatabasePath “C:\Windows\NTDS” -DomainName $domain_name -InstallDns:$true -LogPath “C:\Windows\NTDS” -NoRebootOnCompletion:$false -SiteName “Default-First-Site-Name” -SysvolPath “C:\Windows\SYSVOL” -Force:$true

Restart-Computer