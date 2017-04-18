#!/bin/bash
# Remove Adobe CC Preferences v1.0
# Script which takes in parameters to remove Adobe CC preference files.

currUser=$( who | awk '/console/{print $1}' )

for var in "$@"
do

	if [[ $var = "Illustrator" ]]; then
		prefFiles[0]="/Users/$currUser/Library/Application Support/Adobe/Adobe Illustrator 19"
		prefFiles[1]="/Users/$currUser/Library/Preferences/Adobe Illustrator 19 Settings"
		prefFiles[2]="/Users/$currUser/Library/Preferences/Adobe/Adobe Illustrator"
		prefFiles[3]="/Users/$currUser/Library/Preferences/com.adobe.illustrator.plist"

		for ((i = 0; i < ${#prefFiles[@]}; i++))
		do
			if [ -e "${prefFiles[$i]}" ]; then
	   			rm -R "${prefFiles[$i]}"
	   		elif [[ -d "${prefFiles[$i]}" ]]; then
	   			rm -R "${prefFiles[$i]}"
	   		else
	   			echo "The file ${prefFiles[$i]} either does not exist or has already been deleted."
	   		fi
		done
	fi

	if [[ $var = "Photoshop" ]]; then
		prefFiles[0]="/Users/$currUser/Library/Application Support/Adobe/Adobe Photoshop CC 2015"
		prefFiles[1]="/Users/$currUser/Library/Caches/com.adobe.Photoshop"
		prefFiles[2]="/Users/$currUser/Library/Caches/Adobe/PhotoshopServer"
		prefFiles[3]="/Users/$currUser/Library/Preferences/Adobe Photoshop CC 2015 Paths"
		prefFiles[4]="/Users/$currUser/Library/Preferences/Adobe Photoshop CC 2015 Settings"
		prefFiles[5]="/Users/$currUser/Library/Preferences/com.adobe.Photoshop.plist"
		prefFiles[6]="/Users/$currUser/Library/Preferences/Adobe/Photoshop"
		prefFiles[7]="/Users/$currUser/Library/Saved Application State/com.adobe.Photoshop.savedState"

		for ((i = 0; i < ${#prefFiles[@]}; i++))
		do
			if [ -e "${prefFiles[$i]}" ]; then
				rm -R "${prefFiles[$i]}"
			elif [[ -d "${prefFiles[$i]}" ]]; then
	   			rm -R "${prefFiles[$i]}"
			else
				echo "The file ${prefFiles[$i]} either does not exist or has already been deleted."
			fi
		done
	fi

	if [[ $var = "InDesign" ]]; then
		prefFiles[0]="/Users/$currUser/Library/Caches/Adobe InDesign"
		prefFiles[1]="/Users/$currUser/Library/Caches/com.adobe.InDesign"
		prefFiles[2]="/Users/$currUser/Library/Preferences/Adobe InDesign"
		prefFiles[3]="/Users/$currUser/Library/Saved Application State/com.adobe.InDesign.savedState"
		prefFiles[4]="/Users/$currUser/Library/Preferences/com.adobe.InDesign.plist"

		for ((i = 0; i < ${#prefFiles[@]}; i++))
		do
			if [ -e "${prefFiles[$i]}" ]; then
				rm -R "${prefFiles[$i]}"
			elif [[ -d "${prefFiles[$i]}" ]]; then
	   			rm -R "${prefFiles[$i]}"
			else
				echo "The file ${prefFiles[$i]} either does not exist or has already been deleted."
			fi
		done
	fi

	if [[ $var = "AfterEffects" ]]; then
		prefFiles[0]="/Users/$currUser/Library/Caches/Adobe/After Effects"
		prefFiles[1]="/Users/$currUser/Library/Preferences/Adobe/After Effects"
		prefFiles[2]="/Users/$currUser/Library/Preferences/com.adobe.AfterEffects.plist"
		prefFiles[3]="/Users/$currUser/Library/Preferences/com.Adobe.After Effects.13.5.plist"
		prefFiles[4]="/Users/$currUser/Library/Saved Application State/com.adobe.AfterEffects.savedState"

		for ((i = 0; i < ${#prefFiles[@]}; i++))
		do
			if [ -e "${prefFiles[$i]}" ]; then
				rm -R "${prefFiles[$i]}"
			elif [[ -d "${prefFiles[$i]}" ]]; then
	   			rm -R "${prefFiles[$i]}"
			else
				echo "The file ${prefFiles[$i]} either does not exist or has already been deleted."
			fi
		done
	fi

  if [[ $var = "Audition" ]]; then
    prefFiles[0]="/Users/$currUser/Library/Caches/Adobe/Audition"
    prefFiles[1]="/Users/$currUser/Library/Preferences/Adobe/Audition"
    prefFiles[2]="/Users/$currUser/Library/Preferences/com.Adobe.Audition.8.0.plist"
    prefFiles[3]="/Users/$currUser/Library/Saved Application State/com.adobe.Audition.2015.0.savedState"

    for ((i = 0; i < ${#prefFiles[@]}; i++))
    do
      if [ -e "${prefFiles[$i]}" ]; then
        rm -R "${prefFiles[$i]}"
      elif [[ -d "${prefFiles[$i]}" ]]; then
          rm -R "${prefFiles[$i]}"
      else
        echo "The file ${prefFiles[$i]} either does not exist or has already been deleted."
      fi
    done
  fi

  if [[ $var = "Bridge" ]]; then
		prefFiles[0]="/Users/$currUser/Library/Application Support/Adobe/Bridge CC"
    prefFiles[1]="/Users/$currUser/Library/Caches/Adobe/Bridge CC"
    prefFiles[2]="/Users/$currUser/Library/Preferences/com.adobe.bridge6.plist"
    prefFiles[3]="/Users/$currUser/Library/Saved Application State/com.adobe.bridge6.savedState"

    for ((i = 0; i < ${#prefFiles[@]}; i++))
    do
      if [ -e "${prefFiles[$i]}" ]; then
        rm -R "${prefFiles[$i]}"
      elif [[ -d "${prefFiles[$i]}" ]]; then
          rm -R "${prefFiles[$i]}"
      else
        echo "The file ${prefFiles[$i]} either does not exist or has already been deleted."
      fi
    done
  fi

  if [[ $var = "Dreamweaver" ]]; then
    prefFiles[0]="/Users/$currUser/Library/Preferences/Adobe/Dreamweaver"
    prefFiles[1]="/Users/$currUser/Library/Preferences/com.adobe.dreamweaver-16.0.plist"
		prefFiles[2]="/Users/$currUser/Library/Saved Application State/com.adobe.dreamweaver-16.0.savedState"
		prefFiles[3]="/Users/$currUser/Library/Preferences/Adobe Dreamweaver CC 2015 Prefs"

    for ((i = 0; i < ${#prefFiles[@]}; i++))
    do
      if [ -e "${prefFiles[$i]}" ]; then
        rm -R "${prefFiles[$i]}"
      elif [[ -d "${prefFiles[$i]}" ]]; then
          rm -R "${prefFiles[$i]}"
      else
        echo "The file ${prefFiles[$i]} either does not exist or has already been deleted."
      fi
    done
  fi

  if [[ $var = "Fireworks" ]]; then
		prefFiles[0]="/Users/$currUser/Library/Application Support/Adobe/Fireworks CS6"
    prefFiles[1]="/Users/$currUser/Library/Preferences/Adobe Fireworks CS6"

    for ((i = 0; i < ${#prefFiles[@]}; i++))
    do
      if [ -e "${prefFiles[$i]}" ]; then
        rm -R "${prefFiles[$i]}"
      elif [[ -d "${prefFiles[$i]}" ]]; then
          rm -R "${prefFiles[$i]}"
      else
        echo "The file ${prefFiles[$i]} either does not exist or has already been deleted."
      fi
    done
  fi

  if [[ $var = "Flash" ]]; then
		prefFiles[0]="/Users/$currUser/Library/Application Support/Adobe/Flash CC 2015"
    prefFiles[1]="/Users/$currUser/Library/Preferences/Adobe/Flash/"
    prefFiles[2]="/Users/$currUser/Library/Preferences/com.adobe.Adobe Flash CC 2015.application.plist"

    for ((i = 0; i < ${#prefFiles[@]}; i++))
    do
      if [ -e "${prefFiles[$i]}" ]; then
        rm -R "${prefFiles[$i]}"
      elif [[ -d "${prefFiles[$i]}" ]]; then
          rm -R "${prefFiles[$i]}"
      else
        echo "The file ${prefFiles[$i]} either does not exist or has already been deleted."
      fi
    done
  fi

  if [[ $var = "Lightroom" ]]; then
		prefFiles[0]="/Users/$currUser/Library/Application Support/Adobe/Lightroom"
		prefFiles[1]="/Users/$currUser/Library/Caches/com.adobe.Lightroom6"
    prefFiles[2]="/Users/$currUser/Library/Caches/Adobe/Lighroom"
    prefFiles[3]="/Users/$currUser/Library/Preferences/com.adobe.Lightroom6.LSSharedFileList.plist"
    prefFiles[4]="/Users/$currUser/Library/Preferences/com.adobe.Lightroom6.plist"

    for ((i = 0; i < ${#prefFiles[@]}; i++))
    do
      if [ -e "${prefFiles[$i]}" ]; then
        rm -R "${prefFiles[$i]}"
      elif [[ -d "${prefFiles[$i]}" ]]; then
          rm -R "${prefFiles[$i]}"
      else
        echo "The file ${prefFiles[$i]} either does not exist or has already been deleted."
      fi
    done
  fi

  if [[ $var = "MediaEncoder" ]]; then
    prefFiles[0]="/Users/$currUser/Library/Caches/Adobe/Adobe Media Encoder"
    prefFiles[1]="/Users/$currUser/Library/Preferences/Adobe/Adobe Media Encoder"
    prefFiles[2]="/Users/$currUser/Library/Preferences/com.Adobe.Adobe Media Encoder.9.0.plist"

    for ((i = 0; i < ${#prefFiles[@]}; i++))
    do
      if [ -e "${prefFiles[$i]}" ]; then
        rm -R "${prefFiles[$i]}"
      elif [[ -d "${prefFiles[$i]}" ]]; then
          rm -R "${prefFiles[$i]}"
      else
        echo "The file ${prefFiles[$i]} either does not exist or has already been deleted."
      fi
    done
  fi

  if [[ $var = "Muse" ]]; then
    prefFiles[0]="/Users/$currUser/Library/Caches/com.adobe.Muse.application"
    prefFiles[1]="/Users/$currUser/Library/Preferences/Adobe/Adobe Muse CC"
		prefFiles[2]="/Users/$currUser/Library/Preferences/Adobe/Adobe Muse CC Libraries"
    prefFiles[3]="/Users/$currUser/Library/Preferences/com.adobe.AdobeMuseCC.2015.0"
    prefFiles[4]="/Users/$currUser/Library/Preferences/com.adobe.Muse.application.plist"

    for ((i = 0; i < ${#prefFiles[@]}; i++))
    do
      if [ -e "${prefFiles[$i]}" ]; then
        rm -R "${prefFiles[$i]}"
      elif [[ -d "${prefFiles[$i]}" ]]; then
          rm -R "${prefFiles[$i]}"
      else
        echo "The file ${prefFiles[$i]} either does not exist or has already been deleted."
      fi
    done
  fi

  if [[ $var = "PremierePro" ]]; then
		prefFiles[0]="/Users/$currUser/Library/Application Support/Adobe/Premiere Pro"
    prefFiles[1]="/Users/$currUser/Library/Caches/Adobe/Premiere Pro"
    prefFiles[2]="/Users/$currUser/Library/Preferences/Adobe/Premiere Pro"
    prefFiles[3]="/Users/$currUser/Library/Preferences/com.adobe.AdobePremierePro.plist"
    prefFiles[4]="/Users/$currUser/Library/Preferences/com.Adobe.Premiere Pro.9.0.plist"
    prefFiles[5]="/Users/$currUser/Library/Saved Application State/com.adobe.AdobePremierePro.savedState"

    for ((i = 0; i < ${#prefFiles[@]}; i++))
    do
      if [ -e "${prefFiles[$i]}" ]; then
        rm -R "${prefFiles[$i]}"
      elif [[ -d "${prefFiles[$i]}" ]]; then
          rm -R "${prefFiles[$i]}"
      else
        echo "The file ${prefFiles[$i]} either does not exist or has already been deleted."
      fi
    done
  fi

  if [[ $var = "Acrobat" ]]; then
		prefFiles[0]="/Users/$currUser/Library/Application Support/Adobe/Acrobat"
		prefFiles[1]="/Users/$currUser/Library/Caches/Acrobat"
    prefFiles[2]="/Users/$currUser/Library/Preferences/com.adobe.Acrobat.Pro.plist"
    prefFiles[3]="/Users/$currUser/Library/Saved Application State/com.adobe.Acrobat.Pro.savedState"

    for ((i = 0; i < ${#prefFiles[@]}; i++))
    do
      if [ -e "${prefFiles[$i]}" ]; then
        rm -R "${prefFiles[$i]}"
      elif [[ -d "${prefFiles[$i]}" ]]; then
          rm -R "${prefFiles[$i]}"
      else
        echo "The file ${prefFiles[$i]} either does not exist or has already been deleted."
      fi
    done
  fi

done
