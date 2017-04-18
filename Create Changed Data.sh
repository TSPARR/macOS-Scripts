#!/bin/bash
#Create Changed Data.sh
#Script to create large amounts of changed data in order to test backup software

LoggedOnUser=$(logname)
date=$(date +"%Y-%m-%d_%H-%M-%S")
dataSet=$(( ( RANDOM % 4 )  + 1 ))
echo $dataSet

if [[ ! -d /Users/"$LoggedOnUser"/Desktop/RandomFileTest ]]; then

  mkdir /Users/"$LoggedOnUser"/Desktop/RandomFileTest/ > /dev/null 2>&1

fi

case ${dataSet} in

  1)
    mkfile -n 2g /Users/"$LoggedOnUser"/Desktop/LargeFileTest_"$date" > /dev/null 2>&1
    ;;

  2)
    tar czf /Users/"$LoggedOnUser"/Desktop/Tarred_Logs_"$date" /var/log/ > /dev/null 2>&1
    ;;

  3)
    hdiutil create -volname LargeDMGTest -srcfolder /Library -ov -format UDZO /Users/"$LoggedOnUser"/Desktop/LargeDMGTest_"$date".dmg > /dev/null 2>&1
    ;;
  4)
    zip -r /Users/"$LoggedOnUser"/Desktop/Zipped_Files_"$date" /System/Library/ > /dev/null 2>&1
    ;;

esac
