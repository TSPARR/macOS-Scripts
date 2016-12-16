#!/bin/sh
#Remove Adobe CS6 Preferences
#Script which takes in parameters to remove Adobe CS6 preference files.

currUser=$( who | awk '/console/{print $1}' )

for var in "$@"
do

	if [[ $var = "Illustrator" ]]; then
		prefFiles[0]="/Users/$currUser/Library/Application Support/Adobe/Adobe Illustrator CS6/"
		prefFiles[1]="/Users/$currUser/Library/Caches/com.adobe.illustrator/"
		prefFiles[2]="/Users/$currUser/Library/Preferences/Adobe Illustrator CS6 Settings/"
		prefFiles[3]="/Users/$currUser/Library/Preferences/com.adobe.illustrator.plist"
		prefFiles[4]="/Users/$currUser/Library/Preferences/com.adobe.illustrator.plist.lockfile"
		prefFiles[5]="/Users/$currUser/Library/Saved Application State/com.adobe.illustrator.savedState"

		for ((i = 0; i < ${#prefFiles[@]}; i++))
		do
			if [ -e "${prefFiles[$i]}" ]; then
	   			rm -R "${prefFiles[$i]}"
	   		elif [[ -d "${prefFiles[$i]}" ]]; then
	   			rm -R "${prefFiles[$i]}"
	   		else
	   			echo "The file "${prefFiles[$i]}" either does not exist or has already been deleted."
	   		fi
		done
	fi

	if [[ $var = "Photoshop" ]]; then
		prefFiles[0]="/Users/$currUser/Library/Application Support/Adobe/Adobe Photoshop CS6/"
		prefFiles[1]="/Users/$currUser/Library/Preferences/Adobe Photoshop CS6 Paths"
		prefFiles[2]="/Users/$currUser/Library/Preferences/Adobe Photoshop CS6 Settings/"
		prefFiles[3]="/Users/$currUser/Library/Preferences/com.adobe.Photoshop.plist"
		prefFiles[4]="/Users/$currUser/Library/Preferences/com.adobe.Photoshop.plist.lockfile"
		prefFiles[5]="/Users/$currUser/Library/Saved Application State/com.adobe.Photoshop.savedState"

		for ((i = 0; i < ${#prefFiles[@]}; i++))
		do
			if [ -e "${prefFiles[$i]}" ]; then
				rm -R "${prefFiles[$i]}"
			elif [[ -d "${prefFiles[$i]}" ]]; then
	   			rm -R "${prefFiles[$i]}"
			else
				echo "The file "${prefFiles[$i]}" either does not exist or has already been deleted."
			fi
		done
	fi

	if [[ $var = "InDesign" ]]; then
		prefFiles[0]="/Users/$currUser/Library/Caches/Adobe InDesign/"
		prefFiles[1]="/Users/$currUser/Library/Caches/com.adobe.InDesign/"
		prefFiles[2]="/Users/$currUser/Library/Preferences/Adobe InDesign/"
		prefFiles[3]="/Users/$currUser/Library/Preferences/com.adobe.InDesign.plist"
		prefFiles[4]="/Users/$currUser/Library/Preferences/com.adobe.InDesign.plist.lockfile"
		prefFiles[5]="/Users/$currUser/Library/Saved Application State/com.adobe.InDesign.savedState"

		for ((i = 0; i < ${#prefFiles[@]}; i++))
		do
			if [ -e "${prefFiles[$i]}" ]; then
				rm -R "${prefFiles[$i]}"
			elif [[ -d "${prefFiles[$i]}" ]]; then
	   			rm -R "${prefFiles[$i]}"
			else
				echo "The file "${prefFiles[$i]}" either does not exist or has already been deleted."
			fi
		done
	fi

done
