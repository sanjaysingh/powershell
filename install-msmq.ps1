ForEach($featureName in Get-WindowsOptionalFeature –Online  | ? FeatureName -match "msmq" | select FeatureName)
{
    Enable-WindowsOptionalFeature -Online -FeatureName $featureName.FeatureName -ALL;
}
