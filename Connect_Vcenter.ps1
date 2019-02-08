################ PowerCLI script to connect on Vcenter ################ 
################     Developped by Sebastien Pomme     ################ 
################     Find more on my GitHub     	   ################ 

# How to use the command:
# .\Connect_Vcenter.ps1 -vcserver name_of_vcenter -user username -password password -logspath C:\connect_vcenter.txt
# WARNING : the powercli doesn't not support some specials characters on password parsing input. If needed, enclose the entire string in single-quotes (in that case, the password should not contain any single-quote)

################			Script			################

Import-Module VMware.VimAutomation.Core

param(
    [parameter(Mandatory=$true)] $vcserver,
    [parameter(Mandatory=$true)] $user,
	[parameter(Mandatory=$true)] $password,
	[parameter(Mandatory=$false)] $logpath
	)

Start-Transcript -path $logpath -append

Connect-VIServer -Server $vcserver -Protocol https -User $user -Password $password

Stop-Transcript

################			End Script			################

# Find more information about PowerCLI Commandlet on : https://code.vmware.com/tool/vmware-powercli/6.5
