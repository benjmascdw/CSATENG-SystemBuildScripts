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

5. Run dc1.ps1 (reboot)
    - Sets inital OS settings
6. Re-connect via RDP
7. Run dc1.ps1 - Click "Close" when complete to reboot 
    - Installs Active directory
8. Run dc1.ps1
    - Deploy certificate services
    - Create Simulated Users
9. When prompted for Credentials enter "administrator" and the password.


## DC2 Build Steps
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

5. Run dc2.ps1 (reboot)
6. Re-connect via RDP
7. Run dc2.ps1 (reboot) 
