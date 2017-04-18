#!/bin/bash
# Create Computer Names.sh
# Designed to be used with jamf|PRO Pre-Stage Imaging to easily create a list of computer names

echo "Type the number of machines you need names for and then hit [ENTER]"

read -r machineNumber

echo "Type the prefix you'd like to use for machine names and then hit [ENTER]"

read -r namePrefix

echo "Type the full path and filename of the file you'd like to save and then hit [ENTER]"

read -r filePath

for i in $(seq -f %03g "$machineNumber")
do
	echo -n "$namePrefix-$i," >> "$filePath"
done
