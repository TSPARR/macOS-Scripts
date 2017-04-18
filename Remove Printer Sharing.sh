#!/bin/sh
# Remove Printer Sharing.sh
# Turns off printer sharing across the board

#Unchecks Printer Sharing in the System Preferences Sharing Pane
cupsctl --no-share-printers

#Unchecks individual printers from being shared if previously checked
lpstat -p | grep printer | awk '{print $2}'| xargs -I{} lpadmin -p {} -o printer-is-shared=false

exit
