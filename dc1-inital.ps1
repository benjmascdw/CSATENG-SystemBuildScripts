. ./dc1-vars.ps1

# $domain_name = "csateng.lab"
# $hostname = "DC1"
# $network_interface = "Ethernet0"
# $ip_Address = "10.89.49.68"
# $subnet_mask = "26"
# $default_gateway = "10.89.49.65"
# $dns_Servers = "10.89.49.50, 10.89.49.51"
# $timezone = "Central Standard Time"

Rename-Computer -NewName $hostname 
# Set timezone
Set-TimeZone -Id $timezone 
Set-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\Terminal Server' -name "fDenyTSConnections" -value 0
Enable-NetFirewallRule -DisplayGroup "Remote Desktop"
#New-NetIPAddress –InterfaceAlias $network_interface –IPv4Address $ip_Address –PrefixLength $subnet_mask -DefaultGateway $default_gateway
#Set-DnsClientServerAddress -InterfaceAlias $network_interface -ServerAddresses $dns_Servers
#Set-NetConnectionProfile -InterfaceAlias $network_interface -NetworkCategory Private

# install features 
$featureLogPath = "c:\poshlog\featurelog.txt" 
New-Item $featureLogPath -ItemType file -Force 
$addsTools = "RSAT-AD-Tools" 
Add-WindowsFeature $addsTools 
Get-WindowsFeature | Where installed >>$featureLogPath

Restart-Computer