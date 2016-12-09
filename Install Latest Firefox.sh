#!/bin/bash
# Install Latest Firefox.sh
# Grabs the latest copy of Firefox from their site and installs it

# Checking if Firefox is running
if pgrep "firefox" > /dev/null
then
    killall firefox
fi

# Installing Firefox
curl -L -o /tmp/Firefox.dmg "http://download.mozilla.org/?product=firefox-latest&os=osx&lang=en-US"
hdiutil mount -nobrowse /tmp/Firefox.dmg
cp -R "/Volumes/Firefox/Firefox.app" /Applications
hdiutil unmount "/Volumes/Firefox"
rm /tmp/Firefox.dmg
