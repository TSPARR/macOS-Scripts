#!/bin/sh
# Display Resolution.sh
# Gets the current resolution of computer

echo "<result>$(/usr/sbin/system_profiler SPDisplaysDataType | awk -F: '/Resolution/ {print $2}')</result>"
