################ 		PowerCLI script to remove a snapshot on Powered off vm			################ 
################		Developped by Sebastien Pomme						################ 
################		Find more on my GitHub							################ 
################		https://github.com/sebastienpomme/vmware				################ 

# How to use the command:
# .\RemoveSnapshot.ps1 -snapname name_of_snapshot -cluster clustername -logpath C:\CreateSnapshotlog.txt
# logpath is not mandatory
# For the clustername, it's possible to parse a * to target all cluster on the datacenter : .\RemoveSnapshot.ps1 -snapname name_of_snapshot -cluster *

################			Script			################

param(
	[parameter(Mandatory=$true)] $vmname,
	[parameter(Mandatory=$true)] $snapname,
	[parameter(Mandatory=$true)] $cluster,
	[parameter(Mandatory=$false)] $logpath
)

Start-Transcript -path $logpath -append

$vm = Get-VM -Name * -Location $cluster

$vm | foreach {

        "Commiting/Deleting Snapshot named $snapname for the virtual machine $($_.name) on Esxi $($_.VMHost)"
	$snap = Get-Snapshot -VM $_ -Name $snapname
	Remove-Snapshot -Snapshot $snap -RemoveChildren -Confirm:$false

}
Stop-Transcript


################			End Script			################

# Find more information about PowerCLI Commandlet on : https://code.vmware.com/tool/vmware-powercli/6.5
