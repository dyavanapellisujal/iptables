#!/bin/bash
#set -x
listgenerator() {
    count=0
    list=()
    start=$1
    for ((i = start; i <= 255; i++))
    do	if [ $i -eq 0 ]
    	then
    		continue
        else
        	list[$count]="$2.$i"
        	((count++))
        fi
    done
    echo "${list[@]}"

 }

function mask {
	ip="$1"
	endpoint=$(cutfunc $ip "/" "2")
	echo $endpoint
	}


cutfunc() {

	result=$(echo $1 | cut -d "$2" -f"$3")
	echo $result
}


function listofip24 {
	list=()
	count=0
	ip="$1"
	net=$(cutfunc $ip "/" "1")
	delimiter=","
	start=$(cutfunc $net "." "4")
	start=$((start))
	networkportion=$(echo $ip | tr "." " " | awk '{print $1, $2, $3}' | sed 's/ /./g')
	list=$(listgenerator $start $networkportion)
	echo $list
}

function arglist {

	IFS="," read -r 
	
}

inputacc() {
	list=$1
	for i in ${list[@]}
	do
		echo "$i"
		iptables -I INPUT -s $i -j ACCEPT
	done
}
if [ "$#" -lt  1 ] 
then
	echo -e "Enter arguments"
	echo -e "Usage firewall -range 192.168.0.0/24 -port 1-1024 "
	echo -e "Usage firewall -list "192.168.0.1,192.168.0.2" -plist "22,443" "

else
	echo "1. INPUT/ACCEPT"
	echo "2. INPUT/DROP"
	echo "3. OUTPUT/ACCEPT"
	echo "4. OUTPUT/DROP"

	read -p "Select an option:" opt

	 
	if [ "$1" = "-range" ]
	then
		
		submask=$(mask "$2")
		if [ $submask == "24" ]
		then 
			#IFS="," read -r list networkportion << $(listofip24 
			list=$(listofip24 "$2")
			echo ${list[@]}	
			 
		elif [ "endaddress" == "16"]
		then
			listofip16
		elif [ "endaddress" == "8" ]
		then 
			listofip8
		fi
		
	fi
	if [ "$opt" == "1" ]; then
    	inputacc "${list[@]}"
	elif [ "$opt" = "*" ]; then
    	exit 0
	fi	 
fi

