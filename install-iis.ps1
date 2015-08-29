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

'running with full privileges'

Enable-WindowsOptionalFeature -Online -FeatureName IIS-ApplicationDevelopment,IIS-BasicAuthentication,IIS-ClientCertificateMappingAuthentication,IIS-CommonHttpFeatures,IIS-CustomLogging,IIS-DefaultDocument,IIS-DirectoryBrowsing,IIS-FTPExtensibility,IIS-FTPServer,IIS-FTPSvc,IIS-HealthAndDiagnostics,IIS-HostableWebCore,IIS-HttpCompressionDynamic,IIS-HttpCompressionStatic,IIS-HttpErrors,IIS-HttpLogging,IIS-HttpRedirect,IIS-HttpTracing,IIS-IISCertificateMappingAuthentication,IIS-IPSecurity,IIS-ISAPIExtensions,IIS-ISAPIFilter,IIS-LoggingLibraries,IIS-ManagementConsole,IIS-ManagementScriptingTools,IIS-ManagementService,IIS-Metabase,IIS-Performance,IIS-RequestFiltering,IIS-RequestMonitor,IIS-Security,IIS-ServerSideIncludes,IIS-StaticContent,IIS-URLAuthorization,IIS-WebDAV,IIS-WebServer,IIS-WebServerManagementTools,IIS-WebServerRole,IIS-WindowsAuthentication,IIS-WMICompatibility,WAS-ConfigurationAPI,WAS-ProcessModel,WAS-WindowsActivationService,IIS-WebSockets,IIS-ApplicationInit,IIS-NetFxExtensibility45,IIS-ASPNET45,IIS-CertProvider
