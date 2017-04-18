#!/bin/bash
# Casper File Monitor.sh
# Syncs files from a JDS to a specific folder for AFP/SMB shares

shopt -s nullglob

JDSArray=(/Library/JDS/shares/CasperShare/*)

for (( i = 0; i < ${#JDSArray[@]} ; i++ )); do

	ln -f "${JDSArray[$i]}" /Shared\ Items/CasperShare/Packages/

done

rsync -av --delete /Library/JDS/shares/CasperShare/ /Shared\ Items/CasperShare/Packages/
