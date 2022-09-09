#*********************************************************************
#   Purpose: Parse SAR output from UNIX 
#   Author:  Haim Lichaa 
#   initial 01/11/2016
#   Last Modified: 01/11/2016 - Initial
#*********************************************************************
# Parameters: 
#
# Example:  
#   PowerCLI C:\> powershell .\script.ps1 -ReturnCode 0 -StdOut "rf3sxdb302n2.rf3stg.mfgint.intel.com;597;2016-01-11 16:20:01 UTC;416642920;112599632;21.28;1291172;99482280;2817040;0.50"  
#                                       
#	
#************************************************************************
param([string]$StdOut)

$VERSION="1.0.6"
$PerfObjects="PhysicalDisk","Processor","Memory","Paging","Load","Swap","Network","NetworkErr"
$StdOut="PhysicalDisk;# hostname;interval;timestamp;DEV;tps;rd_sec/s;wr_sec/s;avgrq-sz;avgqu-sz;await;svctm;%util \n PhysicalDisk;orsox1dbm03.rf3stg.mfgint.intel.com;593;2016-02-16 17:20:01 UTC;sda;13.92;0.50;342.61;24.64;0.01;0.79;0.13;0.18 \n PhysicalDisk;orsox1dbm03.rf3stg.mfgint.intel.com;593;2016-02-16 17:20:01 UTC;dm-0;28.22;0.08;225.73;8.00;0.03;1.13;0.05;0.13 \n PhysicalDisk;orsox1dbm03.rf3stg.mfgint.intel.com;593;2016-02-16 17:20:01 UTC;dm-1;0.00;0.00;0.00;0.00;0.00;0.00;0.00;0.00 \n PhysicalDisk;orsox1dbm03.rf3stg.mfgint.intel.com;593;2016-02-16 17:20:01 UTC;dm-2;0.00;0.00;0.00;0.00;0.00;0.00;0.00;0.00 \n PhysicalDisk;orsox1dbm03.rf3stg.mfgint.intel.com;593;2016-02-16 17:20:01 UTC;dm-3;14.65;0.42;116.88;8.01;0.01;0.74;0.03;0.05 \n Processor;# hostname;interval;timestamp;CPU;%user;%nice;%system;%iowait;%steal;%idle \n Processor;orsox1dbm03.rf3stg.mfgint.intel.com;593;2016-02-16 17:20:01 UTC;-1;1.82;0.14;3.21;0.01;0.00;94.82 \n Memory;# hostname;interval;timestamp;kbmemfree;kbmemused;%memused;kbbuffers;kbcached;kbcommit;%commit \n Memory;orsox1dbm03.rf3stg.mfgint.intel.com;593;2016-02-16 17:20:01 UTC;167106380;97058728;36.74;724520;66494188;21190016;7.32 \n Paging;# hostname;interval;timestamp;pswpin/s;pswpout/s \n Paging;orsox1dbm03.rf3stg.mfgint.intel.com;593;2016-02-16 17:20:01 UTC;0.00;0.00 \n Load;# hostname;interval;timestamp;runq-sz;plist-sz;ldavg-1;ldavg-5;ldavg-15 \n Load;orsox1dbm03.rf3stg.mfgint.intel.com;593;2016-02-16 17:20:01 UTC;6;1265;1.89;1.84;1.82 \n Swap;# hostname;interval;timestamp;kbswpfree;kbswpused;%swpused;kbswpcad;%swpcad \n Swap;orsox1dbm03.rf3stg.mfgint.intel.com;593;2016-02-16 17:20:01 UTC;25165820;0;0.00;0;0.00 \n Network;# hostname;interval;timestamp;IFACE;rxpck/s;txpck/s;rxkB/s;txkB/s;rxcmp/s;txcmp/s;rxmcst/s \n Network;orsox1dbm03.rf3stg.mfgint.intel.com;593;2016-02-16 17:20:01 UTC;lo;9.50;9.50;1.25;1.25;0.00;0.00;0.00 \n Network;orsox1dbm03.rf3stg.mfgint.intel.com;593;2016-02-16 17:20:01 UTC;eth0;3.01;2.58;1.39;0.30;0.00;0.00;0.18 \n Network;orsox1dbm03.rf3stg.mfgint.intel.com;593;2016-02-16 17:20:01 UTC;eth1;0.00;0.00;0.00;0.00;0.00;0.00;0.00 \n Network;orsox1dbm03.rf3stg.mfgint.intel.com;593;2016-02-16 17:20:01 UTC;eth4;0.74;1.25;0.10;0.15;0.00;0.00;0.04 \n Network;orsox1dbm03.rf3stg.mfgint.intel.com;593;2016-02-16 17:20:01 UTC;eth5;6.67;0.71;0.83;0.08;0.00;0.00;0.05 \n Network;orsox1dbm03.rf3stg.mfgint.intel.com;593;2016-02-16 17:20:01 UTC;eth2;0.00;0.00;0.00;0.00;0.00;0.00;0.00 \n Network;orsox1dbm03.rf3stg.mfgint.intel.com;593;2016-02-16 17:20:01 UTC;eth3;0.00;0.00;0.00;0.00;0.00;0.00;0.00 \n Network;orsox1dbm03.rf3stg.mfgint.intel.com;593;2016-02-16 17:20:01 UTC;ib0;72.55;15.94;9.94;8.13;0.00;0.00;0.00 \n Network;orsox1dbm03.rf3stg.mfgint.intel.com;593;2016-02-16 17:20:01 UTC;ib1;56.88;0.00;3.11;0.00;0.00;0.00;0.00 \n Network;orsox1dbm03.rf3stg.mfgint.intel.com;593;2016-02-16 17:20:01 UTC;bond0;0.00;0.00;0.00;0.00;0.00;0.00;0.00 \n Network;orsox1dbm03.rf3stg.mfgint.intel.com;593;2016-02-16 17:20:01 UTC;bondib0;129.43;15.94;13.05;8.13;0.00;0.00;0.00 \n Network;orsox1dbm03.rf3stg.mfgint.intel.com;593;2016-02-16 17:20:01 UTC;bondeth0;7.40;1.96;0.93;0.24;0.00;0.00;0.09 \n NetworkErr;# hostname;interval;timestamp;IFACE;rxerr/s;txerr/s;coll/s;rxdrop/s;txdrop/s;txcarr/s;rxfram/s;rxfifo/s;txfifo/s \n NetworkErr;orsox1dbm03.rf3stg.mfgint.intel.com;593;2016-02-16 17:20:01 UTC;lo;0.00;0.00;0.00;0.00;0.00;0.00;0.00;0.00;0.00 \n NetworkErr;orsox1dbm03.rf3stg.mfgint.intel.com;593;2016-02-16 17:20:01 UTC;eth0;0.00;0.00;0.00;0.00;0.00;0.00;0.00;0.00;0.00 \n NetworkErr;orsox1dbm03.rf3stg.mfgint.intel.com;593;2016-02-16 17:20:01 UTC;eth1;0.00;0.00;0.00;0.00;0.00;0.00;0.00;0.00;0.00 \n NetworkErr;orsox1dbm03.rf3stg.mfgint.intel.com;593;2016-02-16 17:20:01 UTC;eth4;0.00;0.00;0.00;0.00;0.00;0.00;0.00;0.00;0.00 \n NetworkErr;orsox1dbm03.rf3stg.mfgint.intel.com;593;2016-02-16 17:20:01 UTC;eth5;0.00;0.00;0.00;0.00;0.00;0.00;0.00;0.00;0.00 \n NetworkErr;orsox1dbm03.rf3stg.mfgint.intel.com;593;2016-02-16 17:20:01 UTC;eth2;0.00;0.00;0.00;0.00;0.00;0.00;0.00;0.00;0.00 \n NetworkErr;orsox1dbm03.rf3stg.mfgint.intel.com;593;2016-02-16 17:20:01 UTC;eth3;0.00;0.00;0.00;0.00;0.00;0.00;0.00;0.00;0.00 \n NetworkErr;orsox1dbm03.rf3stg.mfgint.intel.com;593;2016-02-16 17:20:01 UTC;ib0;0.00;0.00;0.00;0.00;0.00;0.00;0.00;0.00;0.00 \n NetworkErr;orsox1dbm03.rf3stg.mfgint.intel.com;593;2016-02-16 17:20:01 UTC;ib1;0.00;0.00;0.00;56.88;0.00;0.00;0.00;0.00;0.00 \n NetworkErr;orsox1dbm03.rf3stg.mfgint.intel.com;593;2016-02-16 17:20:01 UTC;bond0;0.00;0.00;0.00;0.00;0.00;0.00;0.00;0.00;0.00 \n NetworkErr;orsox1dbm03.rf3stg.mfgint.intel.com;593;2016-02-16 17:20:01 UTC;bondib0;0.00;0.00;0.00;56.88;0.00;0.00;0.00;0.00;0.00 \n NetworkErr;orsox1dbm03.rf3stg.mfgint.intel.com;593;2016-02-16 17:20:01 UTC;bondeth0;0.00;0.00;0.00;0.07;0.00;0.00;0.00;0.00;0.00"

$StdOut=$StdOut.Replace("\n","`n")
$TARGETCOMPUTER=($StdOut.Split("`n")[1]).Split(';')[1]

$SCRIPT_NAME			= 'Intel.FabAuto.Unix.Exadata.Server.PropertyBag.'+$TARGETCOMPUTER+'.ps1'
$Logfile = "c:\Windows\Temp\$SCRIPT_NAME.log"
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
#======================= START OF MAIN ==========================================
## VERY Important.  Need to set PSModule path So we can import.
#The script will fail without this.
#Get the current module path
$p = [Environment]::GetEnvironmentVariable(“PSModulePath”)

#Add to the existing path the additional path to our module
$p += “;d:\Program Files\System Center 2012\Operations Manager\Powershell\”

#Set the new path to the PSModulePath variable
[Environment]::SetEnvironmentVariable(“PSModulePath”,$p)

try {
Import-Module  OperationsManager
#add OpsMgr snapin
add-pssnapin "Microsoft.EnterpriseManagement.OperationsManager.Client";
}
catch [Exception] {
LogWrite "Import-Module Exception: ",$_.Exception.Message
exit 1
}



#Start by setting up API object.
$api = New-Object -comObject 'MOM.ScriptAPI'
LogWrite "Script version $VERSION starting: parameters passed:`r`n STDOUT= $StdOut , AdditionalParams=$AdditionalParams"


$lines=$StdOut.Split("`n")
foreach ($PerfObject in $PerfObjects){
    $matched=$lines | where {$_ -match "$PerfObject;"}	
    
	#first let's grab the header information and place in array $headers
	$headers=$matched[0].Replace("$PerfObject;# ","").Split(";")
	
	###
	#Parse StdOut and Generate property bag
	$matched|ForEach-Object{
	    if ([string]::IsNullOrEmpty($_)) {return}
	    if ( ($_ -match "$PerfObject;# ") -or ($_ -match "RESTART")){return}
	    $data=$_ -replace "`t","" -replace "`n","" -replace "`r","" -replace "$PerfObject;",""
		$data=$data.Trim().Split(";")
		
		#Create SCOM PropertyBag
		$bag = $api.CreatePropertyBag()
		$bag.AddValue("Object",$PerfObject)
		
		for ($i=0; $i -lt $headers.Count ; $i++){
	    if ($headers[$i].Contains("CPU")){
	      if ($data[$i] = "-1"){
	        $data[$i]="_Total"
	      }
	    }
	    
	    ## Since these objects don't have instances we'll need to make one up to avoid getting error
	    if ($PerfObject.Contains("Load") -or $PerfObject.Contains("Swap") -or $PerfObject.Contains("Memory") -or $PerfObject.Contains("Paging")){
	     # $PerfObject,'_Total'
		 try {
		  $bag.AddValue($PerfObject,"_Total")
		  }
		  catch {
		  	
			}
	    }

		$bag.AddValue($headers[$i],$data[$i].TrimEnd() )
	    $h=$headers[$i]
		$d=$data[$i].TrimEnd()
	    LogWrite "Add Value $h=$d"
		#"Add Value $h=$d"
		}
		#$bag
		## Uncomment below, and comment above if using nonnative powershell only
	    $api.AddItem($bag)
	}
}

## Uncomment below if using nonnative powershell only
$api.ReturnItems()

LogWrite "$SCRIPT_NAME completed for $TARGETCOMPUTER"           