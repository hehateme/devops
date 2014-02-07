#!/bin/bash

usage()
{
	cat<< EOF
    usage: $0 options

    OPTIONS:
       -i      Base Image Name to use to create the VM
       -u      User name in the VM being created
       -p      Password for the user in the VM being created   
       -z      Size of VM being created   Small, Medium, Large, ExtraLarge, A5, A6, A7, A8
       -d      Disk Size in GB
       -n      The name of the virtual machine that needs to be created
       -c      The cloud service name
       -a      Affinity Group Name  
       -v      virtual network name
       -s      subnet name 
       -e      Number of data disks to attach
       -m      If present it is a management node 
       -l      location of the VM/Cloud Service
EOF
}

NO_ARGS=0
E_OPTERROR=85

if [ $# -eq "$NO_ARGS" ]
then
	usage
	exit $E_OPTERROR
fi

virtualnetworkname=""
affinitygroupname=""
subnetname=""

while getopts 'i:u:p:z:d:v:c:a:l:n:s:e:m' opt; do
    case $opt in
        i)
            imagename=$OPTARG
            ;;
        u)
            adminusername=$OPTARG
            ;;
        p)
            adminpassword=$OPTARG
            ;;
        z)
            vmsize=$OPTARG
            ;;
        d) 
            disksize=$OPTARG
            ;;
        n)
            virtualmachinename=$OPTARG
            ;;
        c)
            cloudservicename=$OPTARG
            ;;
        a)
            affinitygroupname=$OPTARG
            ;;
        v)
            virtualnetworkname=$OPTARG
            ;;
        s)  
            subnetname=$OPTARG
            ;;
        e)
            datadiskcount=$OPTARG
            ;;
        m)
            management_node=1
            ;;        
	l)
	    location=$OPTARG
	    ;;
        ?)
            usage
	    exit $E_OPTERROR
            ;;
    esac
done

if [ -z "${imagename}" ]; then
	echo "Required argument -i imagenename is missing"
	usage
	exit $E_OPTERROR
fi

if [ -z "${vmsize}" ]; then
	echo "Required argument -z vmsize is missing"
	usage
	exit $E_OPTERROR
fi

if [ -z "${adminusername}" ]; then
	echo "Required argument -u adminusername is missing"
	usage
	exit $E_OPTERROR
fi

if [ -z "${adminpassword}" ]; then
	echo "Required argument -p adminpassword is missing"
	usage
	exit $E_OPTERROR
fi

if [ -z "${disksize}" ]; then
	echo "Required argument -d disksize is missing"
	usage
	exit $E_OPTERROR
fi

if [ -z "${virtualmachinename}" ]; then
	echo "Required argument -n virtualmachinename is missing"
	usage
	exit $E_OPTERROR
fi

if [ -z "${cloudservicename}" ]; then
	echo "Required argument -c cloudservicename is missing"
	usage
	exit $E_OPTERROR
fi

if [ -z "${datadiskcount}" ]; then
	echo "Required argument -e datadiskcount is missing"
	usage
	exit $E_OPTERROR
fi




printf "Image Name:%s\nAdmin UserName:%s\nAdmin Password:%s\nVM Size:%s\nDisk Size:%d\nCloud Service Name:%s\nData Disk Count:%d\nLocation:%s\nAffinity Group Name:%s\nVirtual Network Name:%s\nSubnet Name:%s\nManagement Node:%d\n" $imagename $adminusername $adminpassword $vmsize $disksize $cloudservicename $datadiskcount $location $affinitygroupname $virtualnetworkname $subnetname $management_node


dnsname=$cloudservicename + ".cloudapp.net"

#Check to see if the cloud servide already exists
c=$(azure service show $cloudservicename --json | jq '.ServiceName')
if [[ -z $c ]]; then
	echo "Service does not exist. About to create cloud service:$cloudservicename at location:$location"
	azure service create --location "${location}" --serviceName $cloudservicename 
fi


#create the vm and attach data disks
azure vm create -z $vmsize -n $virtualmachinename -l "${location}" $dnsname $imagename $adminusername $adminpassword
