#!/bin/bash
# Get Last UID.sh
# Gets the latest available UID on the system

lastuseruid=$( dscl . -list /Users UniqueID | awk '{print $2}' | sort -n | tail -n1 )
useruid=$( expr $lastuseruid + 1 )
echo $useruid
