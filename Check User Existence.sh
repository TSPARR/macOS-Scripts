#!/bin/bash
# Check User Existence
# Used to determine if a specific user exists on a given system

result=$(dscl . -list /Users | grep tyler.sparr)

if [ "$result" != "" ]; then
    echo "<result>User Exists</result>"
else
    echo "<result>User Does not Exist</result>"
fi
