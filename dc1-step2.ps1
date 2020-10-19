# Source: https://github.com/DefensiveOrigins/APT06202001/blob/master/Lab-DomainBuildScripts/ADDS-Step2-PreReqs.ps1
# add ADDS, DNS, and GPMC
. ./dc1-vars.ps1

$featureLogPath = "c:\poshlog\featurelog.txt"
start-job -Name addFeature -ScriptBlock { 
Add-WindowsFeature -Name "ad-domain-services" -IncludeAllSubFeature -IncludeManagementTools 
Add-WindowsFeature -Name "dns" -IncludeAllSubFeature -IncludeManagementTools 
Add-WindowsFeature -Name "gpmc" -IncludeAllSubFeature -IncludeManagementTools } 
Wait-Job -Name addFeature 
Get-WindowsFeature | Where installed >> $featureLogPath