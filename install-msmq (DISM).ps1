param([switch]$Elevated)

function Test-Admin {
  $currentUser = New-Object Security.Principal.WindowsPrincipal $([Security.Principal.WindowsIdentity]::GetCurrent())
  $currentUser.IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)
}

if ((Test-Admin) -eq $false)  {
    if ($elevated) 
    {
        # tried to elevate, did not work, aborting
    } 
    else {
        Start-Process powershell.exe -Verb RunAs -ArgumentList ('-noprofile -noexit -file "{0}" -elevated' -f ($myinvocation.MyCommand.Definition))
}

exit
}

$features = DISM.exe /ONLINE /Get-Features /FORMAT:List | Where-Object { $_.StartsWith("Feature Name")}
$msmqFeatureArgs = "";
ForEach ($feature in $features) {
    $featureName = $feature.split(":")[1].trim();
    If($featureName -match "msmq") {
        $msmqFeatureArgs = $msmqFeatureArgs + " /FeatureName:" + $featureName;
    }
}

start-process -NoNewWindow "DISM.exe" "/NoRestart /OnLine /Enable-Feature $msmqFeatureArgs"

