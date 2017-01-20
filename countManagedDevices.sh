#!/bin/bash
# countManagedDevices.sh
# Grabs the count of all managed devices based on pre-determined Group IDs

#display usage information if called
usage(){
	echo "######################"
	echo "Parameters missing."
	echo "Usage: $0 <jss url> <computer group id> <mobile device group id> <username> <password>"
	echo "e.g. $0 jss.company.com 16 4"
	exit 1
}

#make sure the arguments were provided
[[ $# -ne 5 ]] && usage

#define variables
jssURL="https://$1:8443"
outputFile="/tmp/tempList.xml"
reportUser="$4"
reportPass="$5"
computerGroupID=$2
mobileGroupID=$3

#create the temp file if it doesn't already exist
[[ -f "$outputFile" ]] || touch "$outputFile"

#get OS X count
curl -s -H "Accept: application/xml" "$jssURL"/JSSResource/computergroups/id/"$computerGroupID" --user "$reportUser:$reportPass" > "$outputFile"

osXCount=$(xmllint $outputFile --xpath /computer_group/computers/size)

#trim the XML keys from the variable
osXCount=${osXCount#<size>}
osXCount=${osXCount%</size>}

#get mobile device count
curl -s -H "Accept: application/xml" "$jssURL"/JSSResource/mobiledevicegroups/id/"$mobileGroupID" --user "$reportUser:$reportPass" > "$outputFile"
mobileCount=$(xmllint $outputFile --xpath /mobile_device_group/mobile_devices/size)

#trim the xml keys form the variable
mobileCount=${mobileCount#<size>}
mobileCount=${mobileCount%</size>}

#do some complex algebra
totalCount=$((osXCount+mobileCount))

printf "
<prtg>
	<result>
		<channel>Total Managed Devices</channel>
			<value>$totalCount</value>
	</result>

	<result>
		<channel>Managed OS X Devices</channel>
			<value>$osXCount</value>
	</result>
	<result>
		<channel>Managed Mobile Devices</channel>
			<value>$mobileCount</value>
	</result>
</prtg>\n"

exit
