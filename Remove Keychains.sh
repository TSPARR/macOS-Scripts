#!/bin/bash
# Remove Keychains.sh
# This script will remove the keychains of all mobile accounts

userList=$(dscl . list /Users UniqueID | awk '$2 > 1000 {print $1}')

echo "Deleting user keychains..."

for a in $userList ; do
        find /Users -type d -maxdepth 1 -mindepth 1 | grep "$a"
        if [[ $? == 0 ]]; then
            rm -r /Users/"$a"/Library/Keychains/*  #delete the keychain
        fi
done
