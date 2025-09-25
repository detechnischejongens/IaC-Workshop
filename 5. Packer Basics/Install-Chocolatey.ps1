$ErrorActionPreference =  "Stop" #Stops the script if an Error occurs

# Install Chocolatey - https://chocolatey.org/install
Write-Host "##[command][$((Get-Date).ToString("yyyy-MM-dd HH:mm:ss zzz"))] Install-Chocolatey: Starting installation of Chocolatey"

Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))

Write-Host "[$((Get-Date).ToString("yyyy-MM-dd HH:mm:ss zzz"))] Install-Chocolatey: Chocolatey installation completed successfully"