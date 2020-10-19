# CSATENG-SystemBuildScripts

## DC1 Build Steps

1. Clone Template
2. Set Password on first boot
3. Install VMWare tools (Reboot)
4. Open a powershell prompt and run the following commands to Download and extract the build scripts

'''
cd Desktop
(New-Object Net.WebClient).downloadFile("https://github.com/benjmascdw/CSATENG-SystemBuildScripts/archive/main.zip", "c:\Users\Administrator\build.zip")
Expand-Archive build.zip
cd build\CSATENG-SystemBuildScripts-main
'''

5. run dc1-inital.ps1 (reboot)
6. Re-connect via RDP
7. run dc1-step2.ps1 (reboot) 
8. run dc1-step3.ps1 (reboot)
