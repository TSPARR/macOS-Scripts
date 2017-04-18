#!/bin/bash
# Remove MCX.sh
# Removes all traces of MCX that may be hanging around


# Clear caches and opendirectoryd indexes
rm -rf /Library/Managed\ Preferences/
rm -rf /var/db/dslocal/nodes/MCX/
rm -rf /var/db/dslocal/nodes/Default/sqlindex*


#Clear machine cache
dscl . -delete Computers
echo "Cleared machine MCX caches."


# clear the MCXSettings, MCXFlags and cached_groups attributes from $accounts
for user in $(dscl . -list /Users AuthenticationAuthority | grep LocalCachedUser | awk '{print $1}' | tr '\n' ' ')
do
#Clear mcx caches
dscl . -delete "/Users/${user}" MCXSettings
dscl . -delete "/Users/${user}" MCXFlags
dscl . -delete "/Users/${user}" cached_groups
echo "Cleared user MCX for ${user}"
done
exit 0
