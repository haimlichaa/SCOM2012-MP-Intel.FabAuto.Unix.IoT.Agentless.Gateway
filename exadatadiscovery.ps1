#*********************************************************************
#   Purpose: Discovers  Agentless Unix Servers
#       01/07/2016 - Haim Lichaa  - Initial
##  Parameters: SourceId, ManagementenityId, MATCHNamesRegex, ExcludedNamesRegex 
#  
#   Example usage: Powershell .\Script.ps1 "{5D6F1419-6E0A-7033-9A01-E3FB295E946D}" "{D00A3B46-A323-E88C-5B57-94D188A7C320}" ".*ox.*cm.*|.*ox.*dbm.*" ".*ilo.*"
#*********************************************************************
param($sourceId,$managedEntityId,$MATCH,$EXCLUDE)
$VERSION="1.6"


#==================================================================================
# Sub:		LogWrite
# Purpose:	Logs to c:\windows\temp if c:\windows\temp\omdebug.txt exists
#==================================================================================

Function LogWrite
{
    Param ([string]$logstring)
    $LogTime = Get-Date -Format "MM-dd-yyyy_hh-mm-ss"
    if (Test-Path $Logfile) {
        if ((Get-Item $Logfile).length -gt 1024kb){
            Remove-Item $Logfile
        }
    }
    if (Test-Path C:\windows\Temp\omdebug.txt){
        $domain=[Environment]::UserDomainName
        $user=[Environment]::UserName
        Add-content $Logfile -value "[$LogTime]  $domain\$user : $logstring"
    }
}
## VERY Important.  Need to set PSModule path So we can import.
#The script will fail without this.
#Get the current module path
$p = [Environment]::GetEnvironmentVariable("PSModulePath")

#Add to the existing path the additional path to our module
$p += ";d:\Program Files\System Center 2012\Operations Manager\Powershell\"

#Set the new path to the PSModulePath variable
[Environment]::SetEnvironmentVariable("PSModulePath",$p)


try {
    Import-Module  OperationsManager
    #add OpsMgr snapin
    add-pssnapin "Microsoft.EnterpriseManagement.OperationsManager.Client";
}
catch [Exception] {
    LogWrite "Import-Module Exception: ",$_.Exception.Message
    exit 1
}

$SCRIPT_NAME			= 'Intel.FabAuto.Exadata.Server.Discovery.ps1'
$Logfile = "c:\windows\temp\$SCRIPT_NAME.log"


LogWrite "Script v$VERSION"
LogWrite "Arguments: $sourceId, $managedEntityId, $RMSName"

$api = new-object -comObject 'MOM.ScriptAPI'
 
$discoveryData = $api.CreateDiscoveryData(0, $sourceId, $managedEntityId)


#### Get list of Exadata servers in DNS
$dnsServer=((Get-WmiObject Win32_NetworkAdapterConfiguration|where {$_.DNSServerSearchOrder -ne $null}).DNSServerSearchOrder)[0]
$domain=(Get-WmiObject Win32_ComputerSystem).Domain
$query= "SELECT * FROM MicrosoftDNS_AType WHERE ContainerName='"+$domain+"'"

$servers=get-WmiObject -computername $dnsServer -Namespace Root\MicrosoftDNS -Query $query|
                                where {($_.OwnerName  -match "$MATCH") -and 
                                (($_.OwnerName -notmatch "$EXCLUDE") -and ($_.OwnerName -notlike "*[a-zA-Z].$domain"))}|select OwnerName

foreach ($server in $servers){
  try{
      if ($server){
        if ((-not [string]::IsNullOrEmpty($server.OwnerName)) -and (test-connection $server.OwnerName -Count 1 -Quiet)){ #Only if pingable
          $Name=$server.OwnerName 
          try {
            $ip = [System.Net.Dns]::GetHostAddresses($Name)[0].IPAddressToString
          }
          catch {
            $ip=[string]([guid]::NewGuid())
          }
          $instance = $discoveryData.CreateClassInstance("$MPElement[Name='Intel.FabAuto.Unix.Agentless.Computer']$")
           $instance.AddProperty("$MPElement[Name='Intel.FabAuto.Unix.Agentless.Computer']/PrincipalName$", $server.OwnerName)
           $instance.AddProperty("$MPElement[Name='Intel.FabAuto.Unix.Agentless.Computer']/DNSName$", $server.OwnerName)
           $instance.AddProperty("$MPElement[Name='Intel.FabAuto.Unix.Agentless.Computer']/NetworkName$", $server.OwnerName)
           $instance.AddProperty("$MPElement[Name='Intel.FabAuto.Unix.Agentless.Computer']/IPAddress$", $ip)
          $instance.AddProperty("$MPElement[Name='System!System.Entity']/DisplayName$", $server.OwnerName)
          $discoveryData.AddInstance($instance)    
          LogWrite "Adding $Name [$ip] to discovered Exadata servers"
        }
      }
  }
  catch {
    LogWrite "Error Adding $Name of to discovered Exadata servers"
  }
}
$api.Return($discoveryData)
LogWrite "Discovery script completed."