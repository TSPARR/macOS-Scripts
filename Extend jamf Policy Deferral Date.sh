#!/bin/bash
# Extend jamf Policy Deferral Date.sh
# This script will extend the deferral date of a given policy by the configured amount

API_USER=""
API_PASSWORD=""
JAMF_PRO_ADDRESS=""

# ID of the policy to extend
ID=""

# Weekday which the above policy will be extended to
WEEKDAY="Friday"

# Time to set the deferral limit in full 24 hour format
POLICY_TIME="18:00:00.000-0400"

# Do the math to get the future date
EXTENSION_DATE=$(date -v +"$WEEKDAY" +%Y-%m-%d)

API_DATA="<policy><user_interaction><allow_users_to_defer>true</allow_users_to_defer><allow_deferral_until_utc>"$EXTENSION_DATE"T"$POLICY_TIME"</allow_deferral_until_utc></user_interaction></policy>"

curl -sS -k -i -u "$API_USER:$API_PASSWORD" -X PUT -H "Content-Type: text/xml" -d "<?xml version=\"1.0\" encoding=\"ISO-8859-1\"?>$API_DATA" "https://$JAMF_PRO_ADDRESS:8443/JSSResource/policies/id/$ID"
