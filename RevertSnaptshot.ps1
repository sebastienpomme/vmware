################ 		PowerCLI script to revert to a snapshot			################ 
################		Developped by Sebastien Pomme					################ 
################		Find more on my GitHub							################ 
################		https://github.com/sebastienpomme/vmware		################ 

# How to use the command:
# .\RevertSnapshot.ps1 -vmname name_of_vm -snapname name_of_snapshot -cluster clustername -logpath C:\CreateSnapshotlog.txt
# logpath is not mandatory
# For the vm name and the clustername, it's possible to parse a * to target all cluster or all vm on the datacenter : 
# Example : .\CreateSnapshot.ps1 -vmname VM01 -snapname name_of_snapshot -cluster *
# Example : .\CreateSnapshot.ps1 -vmname * -snapname name_of_snapshot -cluster * >> Snapshot's name should be the same for all vm!

################			Script			################

param(
    [parameter(Mandatory=$true)] $vmname,
    [parameter(Mandatory=$true)] $snapname,
	[parameter(Mandatory=$true)] $cluster,
	[parameter(Mandatory=$false)] $logpath
)

Start-Transcript -path $logpath -append

$vm = Get-VM -Name $vmname -Location $cluster

$vm | foreach {

        "Reverting Snapshot named $snapname for the virtual machine $($_.name) on Esxi $($_.VMHost)"
		$snap = Get-Snapshot -VM $_ -Name $snapname
		Set-VM -VM $_ -Snapshot $snap -Confirm:$false

}
Stop-Transcript

################			End Script			################

# Find more information about PowerCLI Commandlet on : https://code.vmware.com/tool/vmware-powercli/6.5
