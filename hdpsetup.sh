#This settings file stores all the settings related to HDP cluster you are setting up
#Affinty group helps you keep your storage and compute in the same region
export affinityGroupName=rajeasthdpag
#Name the region where affinity group should be created. 
#choices are valid values are "East US", "West US", "East Asia", "Southeast Asia", "North Europe", "West Europe"
export affinityGroupLocation="East US"

#name of the storage account here your virtual machines will be stored.
export storageAccount=rajhdpstorage

#Name of the image you will use to create your virtual machines
export imageName=b39f27a8b8c64d52b05eac6a62ebad85__Ubuntu_DAILY_BUILD-precise-12_04_3-LTS-amd64-server-20140204-en-us-30GB

#Size of the Virtual machine. Valid sizes are extrasmall, small, medium, large, extralarge, a5, a6, a7
export instanceSize=small

#Size of the data disk you want to attach to the VM you are creating. You will typically attach at least 1 disk
export diskSizeInGB=5
#Number of disks you want to attach. Small VM can have 2 disks, medium can have 4, large can have 8 and extralarge can have 8 data disks
export numOfDisks=1

#virtual machine settings
export vmNamePrefix=rajbdhdp
export cloudServicePrefix=rajbdhdp
#user name and password for the virtual machine you are creating
export adminUserName=rajsingh
export adminPassword=Password.1!

#setting related to virtual network
export vnetName=rajeasthdp
#address space allows 192.168.0.0, 10.0.0.0 and 172.16.0.0 ip address ranges
#virtual network faq is here http://msdn.microsoft.com/en-us/library/windowsazure/dn133803.aspx
export vnetAddressSpace=172.16.0.0
export vnetCidr=16
export subnetName=mysubnet
export subnetAddressSpace=172.16.1.0
export subnetCidr=24

#These settings are for nodes in the HDP cluster
#Name of the custom image you will use to create your cluster nodes
export nodeImageName=b39f27a8b8c64d52b05eac6a62ebad85__Ubuntu_DAILY_BUILD-precise-12_04_3-LTS-amd64-server-20140204-en-us-30GB
export nodeCount=2
export nodeSize=small
