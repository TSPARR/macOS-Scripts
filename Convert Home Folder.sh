#!/bin/bash
# Convert User Home Directory
# A script which prints out the local user accounts, moves and renames their home folder, and changes the permissions

if [[ $(id -u) != 0 ]]
then
	echo "Must be run as root."
	exit
fi

#display (non-system) user accounts in the local directory
echo "\n\n*************************\nLocal user accounts:"
dscl /Local/Default -list /Users UniqueID | awk '$2 >= 1000 { print $1; }'

#Prompt for new user name
echo "*************************\n\nWhich shortname do you want to convert?"
read oldName

echo "\n********\nYou entered: $oldName";

#Determine the path for the user's home folder for conversion
oldHome=$(dscl . read /Users/$oldName NFSHomeDirectory | awk -F": " '{print $2}')

#Make sure user entered actually exists by checking to make sure its home folder exists.
if [ -z $oldHome ]
then
	echo "User home folder not found - aborting."
	logger "Convert Home: Could not find home folder for user $oldName - exit 1"
	exit
fi

echo "Their home folder is $oldHome"

echo "\n*********\nWhat is their new shortname?";
read newName

echo "\n*********\nAre you sure you want to convert $oldName to $newName? yes/no"
read confirmConvert

#Confirm the action about to take place - exit if !yes
if [ "$confirmConvert" == "yes" ]
then

	newHome="/Users/$newName"
	#echo "(Debug) - Variables: oldName is $oldName \n newName is $newName\n oldHome is $oldHome \n newHome is $newHome\n\n"

	logger "Convert Home: Deleting the $oldName account from the local directory"
	dscl . delete /Users/$oldName
	logger "Convert Home: Renaming home folder to $newHome".

	sleep 5
	echo "Renaming home folder from $oldHome to $newHome"
	mv "$oldHome" "$newHome"

	sleep 3
	echo "Changing ownership of $newHome to $newName"
	logger "Convert Home: Changing ownership of $oldHome to $newName - exit 0"
	chown -Rv "$newName" "$newHome"

	echo "Complete"
else
	echo "No action taken"
	logger "Convert Home: Action not confirmed - no action taken on any accounts"
	exit
fi
