#!/bin/bash
# jamfPro Cleanup.sh
# A script which deletes all policies and smart groups from a jamf|PRO server. Designed for testing purposes

# All defined constants
OUTPUT_XML="/tmp/tempList.xml"
TEMP_XML="/tmp/temp.xml"
STRIPPED_XML="/tmp/stripped.txt"
API_USER=""
API_PASSWORD=""
JAMF_PRO_URL=""

curl -s -k -H "Accept: application/xml" "https://$JAMF_PRO_URL:8443/JSSResource/policies" --user "$API_USER:$API_PASSWORD" > "$OUTPUT_XML"

/usr/bin/xmllint "$OUTPUT_XML" --xpath /policies/policy/id > "$TEMP_XML"

sed -e $'s/<[^>]*>/\\\n/g' "$TEMP_XML" > "$STRIPPED_XML"

for word in $(sed '/^$/d' $STRIPPED_XML); do
  curl -k -X DELETE "https://$JAMF_PRO_URL:8443/JSSResource/policies/id/$word" --user "$API_USER:$API_PASSWORD"
done

curl -s -k -H "Accept: application/xml" "https://$JAMF_PRO_URL:8443/JSSResource/computergroups" --user "$API_USER:$API_PASSWORD" > "$OUTPUT_XML"

/usr/bin/xmllint "$OUTPUT_XML" --xpath /computer_groups/computer_group/id > "$TEMP_XML"

sed -e $'s/<[^>]*>/\\\n/g' "$TEMP_XML" > "$STRIPPED_XML"

for word in $(sed '/^$/d' $STRIPPED_XML); do
  curl -k -X DELETE "https://$JAMF_PRO_URL:8443/JSSResource/computergroups/id/$word" --user "$API_USER:$API_PASSWORD"
done

rm "$OUTPUT_XML"
rm "$TEMP_XML"
rm "$STRIPPED_XML"
