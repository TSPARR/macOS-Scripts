#!/bin/sh
# Uninstall Teamviewer Host

# This script will completely remove Teamviewer Host and all related files

/bin/launchctl unload /Library/LaunchDaemons/com.teamviewer.Helper.plist
/bin/rm -R /Applications/TeamViewerHost.app
/bin/rm -R /Library/LaunchDaemons/com.teamviewer.Helper.plist
/bin/rm -R /Library/PrivilegedHelperTools/com.teamviewer.Helper
/bin/rm -R /Users/ladmin/Library/Caches/com.teamviewer.TeamViewerHost
/bin/rm -R /Users/ladmin/Library/Preferences/com.teamviewer.TeamViewerHost.plist
