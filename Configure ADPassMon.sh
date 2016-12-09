#!/bin/bash
# Configure ADPassMon.sh
# Creates a LaunchAgent and configures ADPassMon with standard config

LoggedOnUser=$(logname)

#Check for ADPassMon.app and exit if not found
if [ ! -d /Applications/ADPassMon.app ]; then
    echo "ADPassMon not found"
    exit 0
fi

#Check for existing launch agent
if [ -f /Users/$LoggedOnUser/Library/LaunchAgents/AD.ADPassMon.plist ]; then
    echo "LaunchAgent for ADPassMon already exists. Removing..."
    rm /Users/$LoggedOnUser/Library/LaunchAgents/AD.ADPassMon.plist
fi

#Write out a LaunchAgent to launch ADPassMon on login
defaults write /Users/$LoggedOnUser/Library/LaunchAgents/AD.ADPassMon.plist Label AD.ADPassMon
defaults write /Users/$LoggedOnUser/Library/LaunchAgents/AD.ADPassMon.plist ProgramArguments -array
defaults write /Users/$LoggedOnUser/Library/LaunchAgents/AD.ADPassMon.plist RunAtLoad -bool YES
/usr/libexec/PlistBuddy -c "Add ProgramArguments: string /Applications/ADPassMon.app/Contents/MacOS/ADPassMon" /Users/$LoggedOnUser/Library/LaunchAgents/AD.ADPassMon.plist
chown -R $LoggedOnUser /Users/$LoggedOnUser/Library/LaunchAgents
chmod 644 /Users/$LoggedOnUser/Library/LaunchAgents/AD.ADPassMon.plist
echo "Created LaunchAgent to launch ADPassMon on login"

#Check for org.pmbuko.ADPassMon.plist
if [ -f /Users/$LoggedOnUser/Library/Preferences/org.pmbuko.ADPassMon.plist ]; then
    echo "Preferences file already exists. Removing..."
    rm /Users/$LoggedOnUser/Library/Preferences/org.pmbuko.ADPassMon.plist
    defaults write /Users/$LoggedOnUser/Library/Preferences/org.pmbuko.ADPassMon accTest 0
    defaults write /Users/$LoggedOnUser/Library/Preferences/org.pmbuko.ADPassMon enableKeychainLockCheck -bool false
    defaults write /Users/$LoggedOnUser/Library/Preferences/org.pmbuko.ADPassMon selectedBehaviour -int 2
    defaults write /Users/$LoggedOnUser/Library/Preferences/org.pmbuko.ADPassMon warningDays -int 5
    chown $LoggedOnUser /Users/$LoggedOnUser/Library/Preferences/org.pmbuko.ADPassMon.plist
else
    defaults write /Users/$LoggedOnUser/Library/Preferences/org.pmbuko.ADPassMon accTest 0
    defaults write /Users/$LoggedOnUser/Library/Preferences/org.pmbuko.ADPassMon enableKeychainLockCheck -bool false
    defaults write /Users/$LoggedOnUser/Library/Preferences/org.pmbuko.ADPassMon selectedBehaviour -int 2
    defaults write /Users/$LoggedOnUser/Library/Preferences/org.pmbuko.ADPassMon warningDays -int 5
    chown $LoggedOnUser /Users/$LoggedOnUser/Library/Preferences/org.pmbuko.ADPassMon.plist
    echo "Created /Users/$LoggedOnUser/Library/Preferences/org.pmbuko.ADPassMon.plist"
fi
