#!/bin/bash
# Get Application Versions.sh
# Iterates over all applications in the /Applications folder and prints out the current version

shopt -s nullglob

AppArray=(/Applications/*)

for (( i = 0; i < ${#AppArray[@]} ; i++ )); do

version=$(mdls "${AppArray[$i]}" -name kMDItemVersion | awk -F'"' '{print $2}')

echo "${AppArray[$i]} is version $version"

done
