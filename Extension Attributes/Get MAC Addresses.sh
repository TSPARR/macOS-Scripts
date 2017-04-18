#!/bin/bash
# Get Mac Addresses.sh
# Gets the Mac Addresses of all network ports on the computer

IFS=$'\n'
#interfaces=($(networksetup -listallnetworkservices| sed 's/:.*//'))
interfaces=($(networksetup -listallhardwareports | grep "Device" | cut -d : -f 2| sed 's/:.*//'))
names=($(networksetup -listallhardwareports | grep "Port" | cut -d : -f 2| sed 's/:.*//'))
# echo "${arr[0]}"
echo "<result>"
unset IFS

for (( i=1; i<"${#interfaces[@]}"; i++ )); do
	curInt="${interfaces["$i"]}"
	curMAC="$(networksetup -getmacaddress "$curInt" | awk '{print $3}')"
	curName="${names["$i"]}"
		if [[ "$curMAC" != "(null)" ]]; then
			echo "$curName ($curInt) $curMAC"
		fi
done
echo "</result>"
