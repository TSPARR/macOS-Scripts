#!/bin/bash
# Generate System Report.sh
# This script will generate a system report of the underlying system


#create the text file to report to
reportFilename="/tmp/System_Report.txt"

#variables
date=$(date)
lastCharsInSerialNum=$(system_profiler SPHardwareDataType | awk '/Serial/ {print $4}' | cut -c 9-)
friendlyName=$(curl -s http://support-sp.apple.com/sp/product?cc="$lastCharsInSerialNum" | awk -F'<configCode>' '{print $2}' | awk -F'</configCode>' '{print $1}')
jamfVersion=$(jamf -version | cut -d'=' -f2)
jssURL=$(jamf checkJSSconnection | grep "Checking" | awk '{print $4}')

#remove a previous report if it exists
if [[ -e "$reportFilename" ]]; then
	rm "$reportFilename"
fi
touch "$reportFilename"

#----------Networking---------
currentWirelessNetwork=$(/System/Library/PrivateFrameworks/Apple80211.framework/Versions/A/Resources/airport -I | awk -F: '/ SSID: / {print $2}' | sed -e 's/SSID: //' | sed -e 's/ //')

wifiOrAirport=$(/usr/sbin/networksetup -listallnetworkservices | grep -Ei '(Wi-Fi|AirPort)')
wirelessDevice=$(/usr/sbin/networksetup -listallhardwareports | awk "/$wifiOrAirport/,/Device/" | awk 'NR==2' | cut -d " " -f 2)
wirelessIP=$(ipconfig getifaddr $wirelessDevice)
wiredDevice=$(networksetup -listallhardwareports | grep -A 1 "Ethernet" | sed -n 's/Device/&/p' | awk '{print $2}')
wiredIP=$(ipconfig getifaddr $wiredDevice)

getWirelesstNetworkAndDisplayIp()
#################################
	{
		if [[ "$wirelessIP" == "" ]]; then
			wirelessIP="None"
		fi
		if [[ "$currentWirelessNetwork" == "" ]]; then
			currentWirelessNetwork="Wi-Fi Off or Not Connected"
		fi
		printf "\tCurrent Network: $currentWirelessNetwork\n" >> $reportFilename
		printf "\tWireless IP:\t $wirelessIP\n" >> $reportFilename
	}


displayEthernetIp()
###################
	{
	currentIPs=$(ifconfig | grep inet | grep -v inet6 | grep -v 127 | grep -v $wirelessIP | awk '{print $2}')
	printf "\n\tOther IP addresses:\n\t$currentIPs\n" >> $reportFilename

	printf "\n\tPublic IP:\t$(curl icanhazip.com)\n\n" >> $reportFilename

	# # If the Ethernet adapter is not equal to a null value (no IP address), then
	# if [ -z "$en0" ];then
 #        printf "\tEthernet IP\t\t\t$wiredIP\n" >> $reportFilename
	# else
 #        printf "\tEthernet IP\t\t\tINACTIVE\n" >> $reportFilename
	# fi

	}



# Power and reboot

#----------FUNCTIONS---------
displayLastRebootAndShutdown()
##############################
	{
	# Echo the word last, then run the last command to get a list of events
	# Use grep to search for reboot or shutdown |
	# Show only the last entry using tail |
	# awk out the third field and everything after it (the date and time)
	# Store this in a variable to be echoed back later
	lastReboot=$(last | grep reboot | head -n 1 | awk '{print substr ($0, index ($0, $3))}')
	lastShutdown=$(last | grep shutdown | head -n 1 | awk '{print substr ($0, index ($0, $3))}')

	printf "\tLast reboot:\t\t$lastReboot\t\t$sleepTime\n" >> $reportFilename
	printf "\tLast shutdown:\t\t$lastShutdown\t\t$sleepTime\n" >> $reportFilename

	}

displayLastSleepAndWakeTimes()
##############################
	{
	# Uses sysctl to print the sleeptime |
	# awk out only the ninth column of text and everything that precedes it
	# Store all of this in a variable for echoing back later
	sleepTime=$(sysctl -n kern.sleeptime | awk '{print $9, $10, $11, $12}' | cut -d':' -f1 -f2)

	# Uses sysctl to print the waketime |
	# awk out only the ninth column of text and everything that precedes it
	# Store all of this in a variable for echoing back later
	wakeTime=$(sysctl -n kern.waketime | awk '{print $9, $10, $11, $12}' | cut -d':' -f1 -f2)

	printf "\tLast sleeptime:\t\t$sleepTime\n" >> $reportFilename
	printf "\tLast waketime:\t\t$wakeTime\n" >> $reportFilename

	}

displayWakeReason()
###################
	{
	# Display the system log |
	# grep "Wake reason" (using case insensitivity) |
	# tail only the last entry |
	# grep but print only the word (-o)
	# One of these codes will relate to a certain type of wake event
	# Store this information in a variable, which will be evaluated in the case statement
	wakeReason=$(syslog | grep -i "Wake reason" | tail -n1 | grep -o "OHC\|EHC\|USB\|Lid\|PowerButton\|RTC\|ACAttach\|ACDetach\|XHC\|SleepTimer|")
	wakeReasonFriendly=""

	# Evaluate the variable wakeReason, which contains a single entry for a type of wake event
	case $wakeReason in
		# If it equals "OHC," printf the type of wake event
		OHC) wakeReasonFriendly="\tWake Reason:\t\tOpen Host Controller--USB or Firewire";;
		# If it equals "EHC," printf the type of wake event
		EHC) wakeReasonFriendly="\tWake Reason:\t\tEnhanced Host Controller--USB, wireless, or Bluetooth";;
		# etc.
		USB) wakeReasonFriendly="\tWake Reason:\t\t\tUniversal Serial Bus--USB device";;
		# etc.
		Lid) wakeReasonFriendly="\tWake Reason:\t\tLid--Opening of the lid";;
		PowerButton) wakeReasonFriendly="\tWake Reason:\t\tPower button--Power button";;
		ACAttach) wakeReasonFriendly="\tWake Reason:\t\tAC Attached--Charger Connected";;
		ACDetach) wakeReasonFriendly="\tWake Reason:\t\tAC Detached--Charger Disconnected";;
		RTC) wakeReasonFriendly="\tWake Reason:\t\tReal Time Clock--a scheduled event: Energy Saver, launchd, user apps, backup software)";;\
		*) wakeReasonFriendly="\tWake Reason:\t\tI don't know what woke me up"
	# Close the case statement with "case" in reverse
	esac

	#Write reason to report
	printf "$wakeReasonFriendly\n" >> $reportFilename
	}


#JSS
#Check JSS connection
jamf checkJSSConnection -retry 0 &>/dev/null
# If the last command completed successfully
if [ $? = 0 ];then
	# Then create a variable that runs the command again, but
	jssConnection=$(jamf checkJSSConnection -retry 0 | grep "available")
else
	jssConnection=$(jamf checkJSSConnection -retry 0 | grep "Could not connect")
fi

#Compile the report
printf "System Information Report: $date\n\n" >> $reportFilename
printf "COMPUTER NAME AND MODEL:\n\tOS Version:\t\t\t`sw_vers | grep ProductVersion | awk '{print $2}'`\n" >> $reportFilename
printf "\tHardware Model:\t\t`sysctl -n hw.model`\n" >> $reportFilename
printf "\tFriendly name:\t\t$friendlyName\n" >> $reportFilename
printf "\tComputer Name:\t\t`scutil --get ComputerName`\n" >> $reportFilename

printf "\nJSS Status:\n" >> $reportFilename
printf "\tJAMF Binary version: $jamfVersion\n" >> $reportFilename
printf "\tJSS Connection:\t\t$jssConnection\n" >> $reportFilename
printf "\tJSS URL:\t\t\t$jssURL\n" >> $reportFilename

printf "\n\nNETWORK\n" >> $reportFilename
getWirelesstNetworkAndDisplayIp
displayEthernetIp

printf "\nREBOOT, SHUTDOWN, AND POWER\n" >> $reportFilename
displayLastRebootAndShutdown
displayLastSleepAndWakeTimes
displayWakeReason

#------Configuration Profiles-----------------
howManyProfiles=$(profiles -C | awk '/installed/ {print $3}')

printf "\n\nPROFILES\n" >> $reportFilename

if [ $howManyProfiles != "no" ];then
	# List the amount profiles that are "installed"
	profilesStatus=$(profiles -C | awk /installed/)
	printf "\t $profilesStatus:\n" >> $reportFilename

	# Sorted list of installed profiles
	profiles -Cvv | awk '/attribute\:\ name/ {print "\t\t➡ " substr ($0, index ($0,$4))}' | sort >> $reportFilename
else
	# If none, it will just read, "There are no system configuration profiles installed."
	noneInstalled=$(profiles -C | awk '/installed/')
	printf "\t $noneInstalled" >> $reportFilename
fi

printf "\n\nJAMF log:\n" >> $reportFilename
printf "*********\n" >> $reportFilename
tail -n 10 /var/log/jamf.log >> $reportFilename

open "$reportFilename"
