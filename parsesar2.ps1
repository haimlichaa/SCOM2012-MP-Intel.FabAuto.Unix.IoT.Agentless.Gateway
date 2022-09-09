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
param([string]$StdOut,[string]$AdditionalParams)

$VERSION="1.0.5"
$PerfObjects="PhysicalDisk","Processor","Memory","Paging","Load","Swap","Network","NetworkErr"
#Constants used for event logging
# Sample STDOut Remove comment to test
$StdOut="PhysicalDisk;# hostname;interval;timestamp;DEV;tps;rd_sec/s;wr_sec/s;avgrq-sz;avgqu-sz;await;svctm;%util
PhysicalDisk;orsox1dbm02.rf3stg.mfgint.intel.com;594;2016-02-16 02:00:01 UTC;sda;144.46;0.31;40274.28;278.79;23.90;165.47;0.96;13.90
PhysicalDisk;orsox1dbm02.rf3stg.mfgint.intel.com;594;2016-02-16 02:00:01 UTC;dm-0;5016.54;0.01;40132.34;8.00;815.57;162.57;0.03;13.62
PhysicalDisk;orsox1dbm02.rf3stg.mfgint.intel.com;594;2016-02-16 02:00:01 UTC;dm-1;0.00;0.01;0.00;8.00;0.00;3.00;3.00;0.00
PhysicalDisk;orsox1dbm02.rf3stg.mfgint.intel.com;594;2016-02-16 02:00:01 UTC;dm-2;0.00;0.01;0.00;8.00;0.00;7.00;7.00;0.00
PhysicalDisk;orsox1dbm02.rf3stg.mfgint.intel.com;594;2016-02-16 02:00:01 UTC;dm-3;17.77;0.23;141.94;8.00;0.97;54.35;4.93;8.76
Processor;# hostname;interval;timestamp;CPU;%user;%nice;%system;%iowait;%steal;%idle
Processor;orsox1dbm02.rf3stg.mfgint.intel.com;594;2016-02-16 02:00:01 UTC;-1;1.83;0.08;4.20;0.95;0.00;92.94
Memory;# hostname;interval;timestamp;kbmemfree;kbmemused;%memused;kbbuffers;kbcached;kbcommit;%commit
Memory;orsox1dbm02.rf3stg.mfgint.intel.com;594;2016-02-16 02:00:01 UTC;120861204;143303904;54.25;15187448;96849500;96647068;33.40
Paging;# hostname;interval;timestamp;pswpin/s;pswpout/s
Paging;orsox1dbm02.rf3stg.mfgint.intel.com;594;2016-02-16 02:00:01 UTC;0.00;0.00
Load;# hostname;interval;timestamp;runq-sz;plist-sz;ldavg-1;ldavg-5;ldavg-15
Load;orsox1dbm02.rf3stg.mfgint.intel.com;594;2016-02-16 02:00:01 UTC;6;1522;2.19;2.49;2.64
Swap;# hostname;interval;timestamp;kbswpfree;kbswpused;%swpused;kbswpcad;%swpcad
Swap;orsox1dbm02.rf3stg.mfgint.intel.com;594;2016-02-16 02:00:01 UTC;25165820;0;0.00;0;0.00
Network;# hostname;interval;timestamp;IFACE;rxpck/s;txpck/s;rxkB/s;txkB/s;rxcmp/s;txcmp/s;rxmcst/s
Network;orsox1dbm02.rf3stg.mfgint.intel.com;594;2016-02-16 02:00:01 UTC;lo;15.94;15.94;2.29;2.29;0.00;0.00;0.00
Network;orsox1dbm02.rf3stg.mfgint.intel.com;594;2016-02-16 02:00:01 UTC;eth0;1.60;0.41;0.12;0.04;0.00;0.00;0.18
Network;orsox1dbm02.rf3stg.mfgint.intel.com;594;2016-02-16 02:00:01 UTC;eth1;0.00;0.00;0.00;0.00;0.00;0.00;0.00
Network;orsox1dbm02.rf3stg.mfgint.intel.com;594;2016-02-16 02:00:01 UTC;eth4;5.93;0.00;0.65;0.00;0.00;0.00;0.01
Network;orsox1dbm02.rf3stg.mfgint.intel.com;594;2016-02-16 02:00:01 UTC;eth5;7.30;1.48;0.88;0.19;0.00;0.00;0.02
Network;orsox1dbm02.rf3stg.mfgint.intel.com;594;2016-02-16 02:00:01 UTC;eth2;0.00;0.00;0.00;0.00;0.00;0.00;0.00
Network;orsox1dbm02.rf3stg.mfgint.intel.com;594;2016-02-16 02:00:01 UTC;eth3;0.00;0.00;0.00;0.00;0.00;0.00;0.00
Network;orsox1dbm02.rf3stg.mfgint.intel.com;594;2016-02-16 02:00:01 UTC;ib0;70.99;14.00;9.63;7.64;0.00;0.00;0.00
Network;orsox1dbm02.rf3stg.mfgint.intel.com;594;2016-02-16 02:00:01 UTC;ib1;57.04;0.00;3.12;0.00;0.00;0.00;0.00
Network;orsox1dbm02.rf3stg.mfgint.intel.com;594;2016-02-16 02:00:01 UTC;bond0;0.00;0.00;0.00;0.00;0.00;0.00;0.00
Network;orsox1dbm02.rf3stg.mfgint.intel.com;594;2016-02-16 02:00:01 UTC;bondib0;128.03;14.00;12.75;7.64;0.00;0.00;0.00
Network;orsox1dbm02.rf3stg.mfgint.intel.com;594;2016-02-16 02:00:01 UTC;bondeth0;13.22;1.48;1.53;0.19;0.00;0.00;0.03
NetworkErr;# hostname;interval;timestamp;IFACE;rxerr/s;txerr/s;coll/s;rxdrop/s;txdrop/s;txcarr/s;rxfram/s;rxfifo/s;txfifo/s
NetworkErr;orsox1dbm02.rf3stg.mfgint.intel.com;594;2016-02-16 02:00:01 UTC;lo;0.00;0.00;0.00;0.00;0.00;0.00;0.00;0.00;0.00
NetworkErr;orsox1dbm02.rf3stg.mfgint.intel.com;594;2016-02-16 02:00:01 UTC;eth0;0.00;0.00;0.00;0.00;0.00;0.00;0.00;0.00;0.00
NetworkErr;orsox1dbm02.rf3stg.mfgint.intel.com;594;2016-02-16 02:00:01 UTC;eth1;0.00;0.00;0.00;0.00;0.00;0.00;0.00;0.00;0.00
NetworkErr;orsox1dbm02.rf3stg.mfgint.intel.com;594;2016-02-16 02:00:01 UTC;eth4;0.00;0.00;0.00;5.93;0.00;0.00;0.00;0.00;0.00
NetworkErr;orsox1dbm02.rf3stg.mfgint.intel.com;594;2016-02-16 02:00:01 UTC;eth5;0.00;0.00;0.00;0.00;0.00;0.00;0.00;0.00;0.00
NetworkErr;orsox1dbm02.rf3stg.mfgint.intel.com;594;2016-02-16 02:00:01 UTC;eth2;0.00;0.00;0.00;0.00;0.00;0.00;0.00;0.00;0.00
NetworkErr;orsox1dbm02.rf3stg.mfgint.intel.com;594;2016-02-16 02:00:01 UTC;eth3;0.00;0.00;0.00;0.00;0.00;0.00;0.00;0.00;0.00
NetworkErr;orsox1dbm02.rf3stg.mfgint.intel.com;594;2016-02-16 02:00:01 UTC;ib0;0.00;0.00;0.00;0.00;0.00;0.00;0.00;0.00;0.00
NetworkErr;orsox1dbm02.rf3stg.mfgint.intel.com;594;2016-02-16 02:00:01 UTC;ib1;0.00;0.00;0.00;57.04;0.00;0.00;0.00;0.00;0.00
NetworkErr;orsox1dbm02.rf3stg.mfgint.intel.com;594;2016-02-16 02:00:01 UTC;bond0;0.00;0.00;0.00;0.00;0.00;0.00;0.00;0.00;0.00
NetworkErr;orsox1dbm02.rf3stg.mfgint.intel.com;594;2016-02-16 02:00:01 UTC;bondib0;0.00;0.00;0.00;57.04;0.00;0.00;0.00;0.00;0.00
NetworkErr;orsox1dbm02.rf3stg.mfgint.intel.com;594;2016-02-16 02:00:01 UTC;bondeth0;0.00;0.00;0.00;5.93;0.00;0.00;0.00;0.00;0.00"


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
		$bag
		## Uncomment below, and comment above if using native powershell only
	    #$api.AddItem($bag)
	}
}

## Uncomment below if using native powershell only
#$api.ReturnItems()

LogWrite "$SCRIPT_NAME completed for $TARGETCOMPUTER"   