####
# Purpose: Initial computer configuration
# Author: Ben Mason
#

# File containing Computer Specific Settings
. ./dc1-vars.ps1
$setipaddress=$false
# $domain_name = "csateng.lab"
# $hostname = "DC1"
# $network_interface = "Ethernet0"e
# $ip_Address = "10.89.49.68"
# $subnet_mask = "26"
# $default_gateway = "10.89.49.65"
# $dns_Servers = "10.89.49.50, 10.89.49.51"
# $timezone = "Central Standard Time"

Rename-Computer -NewName $hostname 
Set-TimeZone -Id $timezone 
# Enable RDP
Set-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\Terminal Server' -name "fDenyTSConnections" -value 0
Enable-NetFirewallRule -DisplayGroup "Remote Desktop"

if ($setipaddress -eq $true) {
    New-NetIPAddress –InterfaceAlias $network_interface –IPv4Address $ip_Address –PrefixLength $subnet_mask -DefaultGateway $default_gateway
    Set-DnsClientServerAddress -InterfaceAlias $network_interface -ServerAddresses $dns_Servers
}
# Set Adapter Category
Set-NetConnectionProfile -InterfaceAlias $network_interface -NetworkCategory Private

Restart-Computer