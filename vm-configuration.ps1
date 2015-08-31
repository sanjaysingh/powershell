Set-ExecutionPolicy -ExecutionPolicy Bypass
function Disable-InternetExplorerESC {
    $AdminKey = "HKLM:\SOFTWARE\Microsoft\Active Setup\Installed Components\{A509B1A7-37EF-4b3f-8CFC-4F3A74704073}"
    $UserKey = "HKLM:\SOFTWARE\Microsoft\Active Setup\Installed Components\{A509B1A8-37EF-4b3f-8CFC-4F3A74704073}"
    Set-ItemProperty -Path $AdminKey -Name "IsInstalled" -Value 0 -Force
    Set-ItemProperty -Path $UserKey -Name "IsInstalled" -Value 0 -Force
    Stop-Process -Name Explorer -Force
    Write-Host "IE Enhanced Security Configuration (ESC) has been disabled." -ForegroundColor Green
}
function Enable-InternetExplorerESC {
    $AdminKey = "HKLM:\SOFTWARE\Microsoft\Active Setup\Installed Components\{A509B1A7-37EF-4b3f-8CFC-4F3A74704073}"
    $UserKey = "HKLM:\SOFTWARE\Microsoft\Active Setup\Installed Components\{A509B1A8-37EF-4b3f-8CFC-4F3A74704073}"
    Set-ItemProperty -Path $AdminKey -Name "IsInstalled" -Value 1 -Force
    Set-ItemProperty -Path $UserKey -Name "IsInstalled" -Value 1 -Force
    Stop-Process -Name Explorer
    Write-Host "IE Enhanced Security Configuration (ESC) has been enabled." -ForegroundColor Green
}
function Disable-UserAccessControl {
    Set-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" -Name "ConsentPromptBehaviorAdmin" -Value 00000000 -Force
    Write-Host "User Access Control (UAC) has been disabled." -ForegroundColor Green    
}
Disable-UserAccessControl
Disable-InternetExplorerESC

$exclueFeatures = "IIS-IIS6ManagementCompatibility".ToLower(),"IIS-ODBCLogging".ToLower(),"IIS-CGI".ToLower(),"IIS-LegacyScripts".ToLower(),"IIS-LegacySnapIn","IIS-ASP"
 ForEach($featureName in Get-WindowsOptionalFeature –Online  | ? FeatureName -match "iis" | select FeatureName){
     If($exclueFeatures -notcontains $featureName.FeatureName) {
        Enable-WindowsOptionalFeature -Online -FeatureName $featureName.FeatureName -All;
     }
 }
 
ForEach($featureName in Get-WindowsOptionalFeature –Online  | ? FeatureName -match "msmq" | select FeatureName)
{
    Enable-WindowsOptionalFeature -Online -FeatureName $featureName.FeatureName -ALL;
}
iex ((new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1'))
choco install googlechrome
