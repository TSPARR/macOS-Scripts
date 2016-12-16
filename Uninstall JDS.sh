#!/bin/sh
# Uninstall JDS
# This script will completely remove a JDS instance and all related files

/bin/launchctl unload /Library/LaunchDaemons/com.jamfsoftware.jamfdspolicy.plist
/bin/cp /Library/JDS/conf/.0000_any_443_.conf /Library/Server/Web/Config/apache2/sites/0000_any_443_.conf
/bin/rm -R /Library/JDS
/bin/rm -R /Library/LaunchDaemons/com.jamfsoftware.jamfdspolicy.plist
/bin/rm -R /usr/local/bin/jamfds
