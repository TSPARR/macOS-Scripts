#!/bin/bash
# jamf Site Extension Attribute.sh
# Uses the API to grab the currently assigned site in the jamf Pro Server

#define some variables
jssURL="https://<jssURL>:8443"
outputFile="/tmp/computerRecord.xml"
reportUser="api_user"
reportPass="api_password"

#grab the serial number of the device
serial=$(ioreg -c "IOPlatformExpertDevice" | awk -F '"' '/IOPlatformSerialNumber/ {print $4}')

#Query the JSS for the serial number's inventory report
curl -sk "$jssURL"/JSSResource/computers/serialnumber/"$serial" --user "$reportUser:$reportPass" > "$outputFile"

#parse the xml for the key we need
xmllint -format "$outputFile" -output "$outputFile"
serialSite=$(xmllint $outputFile --xpath /computer/general/site/name |  grep "<name>")

#clean up result string to remove XML tag
serialSite=${serialSite#<name>}
serialSite=${serialSite%<\/name>}

#return the result in JSS extension attribute format
echo "<result>$serialSite</result>"
