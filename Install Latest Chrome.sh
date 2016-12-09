#!/bin/bash
# Install Latest Chrome.sh
# Grabs the latest version of Chrome from their site and installs it

# Checking if Chrome is running
if pgrep "Google Chrome" > /dev/null
then
    killall "Google Chrome"
fi

# Installing Chrome
curl -L -o /tmp/googlechrome.dmg "https://dl.google.com/chrome/mac/stable/GGRO/googlechrome.dmg"
hdiutil mount -nobrowse /tmp/googlechrome.dmg
cp -R "/Volumes/Google Chrome/Google Chrome.app" /Applications
hdiutil unmount "/Volumes/Google Chrome"
rm /tmp/googlechrome.dmg
