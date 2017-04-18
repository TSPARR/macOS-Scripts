#!/bin/bash
# Application Last Used Date.sh
# Accepts the path of an application to check its last opened date

APPLICATION_PATH=$4

if [ ! -e "$APPLICATION_PATH" ]; then
    result="Not Present"
fi

if [ -e "$APPLICATION_PATH" ]; then
    result=$(mdls "$APPLICATION_PATH" | grep kMDItemLastUsedDate | awk '{ $1 = $1 } { print }' | cut -c 23-41)
fi

if [ "$result" == "" ]; then
    result="2001-01-01 01:01:01"
fi

echo "<result>$result</result>"
