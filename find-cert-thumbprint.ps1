cd $PSScriptRoot

$certDirectory = $PSScriptRoot + "\"
$certList = Get-ChildItem $certDirectory | where {$_.extension -eq ".cer"}

$certList

# For each cert in the folder, grab the thumbprint
foreach ($cert in $certList) 
{
	$certPrint = New-Object System.Security.Cryptography.X509Certificates.X509Certificate2
	$certDirectory+$cert.Name
	$certPrint.Import($certDirectory+$cert.Name)
	
	Write-Host $certPrint.Thumbprint
       
}
