################ 		PowerCLI script to take a snapshot for all powered off vm		################ 
################		Developped by Sebastien Pomme						################ 
################		Find more on my GitHub							################ 
################		https://github.com/sebastienpomme/vmware				################ 

# How to use the command:
# .\TakeSnapshot.ps1 -snapname name_of_snapshot -cluster clustername -logpath C:\CreateSnapshotlog.txt
# logpath is not mandatory
# For the clustername, it's possible to parse a * to target all cluster on the datacenter : .\TakeSnapshot.ps1 -snapname name_of_snapshot -cluster *

################			Script			################

param(
	[parameter(Mandatory=$true)] $snapname,
	[parameter(Mandatory=$true)] $cluster,
	[parameter(Mandatory=$false)] $logpath
)

Start-Transcript -path $logpath -append

$vm = Get-VM -Name * -Location $cluster

$vm | foreach {

    if ($_.PowerState -eq "PoweredOff") {
        "Creating Snapshot named $snapname for the virtual machine $($_.name) on Esxi $($_.VMHost)"
		New-Snapshot -VM $_ -name $snapname -confirm:$false
    }
    else {
        "$($_.name) is PoweredOn on $($_.VMHost) - No Snapshot Created"
        sleep 0
    }
}
Stop-Transcript

################			End Script			################

# Find more information about PowerCLI Commandlet on : https://code.vmware.com/tool/vmware-powercli/6.5
