#!/bin/sh
# Script to download and install Flash Player.
# Only works on Intel systems.
# 

dmgfile="flash.dmg"
osxversion=`sw_vers | grep 'ProductVersion:' | grep -o '[0-9]*\.[0-9]*' | awk 'NR < 2'`

echo "Updating Flash player..."
echo "OSX Version: ${osxversion}"
# Get the latest version of Flash Player available from Adobe's About Flash page.
latestver=`/usr/bin/curl -s http://www.adobe.com/software/flash/about/ | sed -n '/Safari/,/<\/tr/s/[^>]*>\([0-9].*\)<.*/\1/p'`
# Get the version number of the currently-installed Flash Player, if any.
if [ -e "/Library/Internet Plug-Ins/Flash Player.plugin" ]; then
	currentinstalledver=`/usr/bin/defaults read /Library/Internet\ Plug-Ins/Flash\ Player.plugin/Contents/version CFBundleShortVersionString`
else
	currentinstalledver="none"
fi
# Compare the two versions, if they are different or Flash is not present then download and install the new version.
if [ "${currentinstalledver}" != "${latestver}" ]; then
	echo "Current Flash version: ${currentinstalledver}" 
	echo "Available Flash version: ${latestver}" 
	echo "Downloading newer version." 
	url="https://fpdownload.macromedia.com/get/flashplayer/pdc/$latestver/install_flash_player_osx.dmg"
	echo "URL: $url"
	/usr/bin/curl -s -o `/usr/bin/dirname $0`/flash.dmg $url
	echo "Mounting installer disk image." 
	mountpoint="$(dirname $0)/FlashInstall"
	/usr/bin/hdiutil attach `dirname $0`/flash.dmg -nobrowse -quiet -mountpoint $mountpoint
	echo "Installing..." 
	installer -pkg $mountpoint/Install\ Adobe\ Flash\ Player.app/Contents/Resources/Adobe\ Flash\ Player.pkg -target /
	echo "Unmounting installer disk image." 
	/usr/bin/hdiutil detach $mountpoint -quiet
	echo "Deleting disk image." 
	/bin/rm `/usr/bin/dirname $0`/${dmgfile}
	newlyinstalledver=`/usr/bin/defaults read /Library/Internet\ Plug-Ins/Flash\ Player.plugin/Contents/version CFBundleShortVersionString`
	if [ "${latestver}" == "${newlyinstalledver}" ]; then
		echo "SUCCESS: Flash has been updated to version ${newlyinstalledver}" 
	else
		echo "ERROR: Flash update unsuccessful, version remains at ${currentinstalledver}." 
	fi
# If Flash is up to date already, just log it and exit.
else
	echo "Flash is already up to date, running ${currentinstalledver}." 
fi