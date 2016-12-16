#!/bin/sh
# XProtectVersions.sh
# Lists the minimum versions required by XProtect

JAVA=$(/usr/libexec/PlistBuddy -c "print :PlugInBlacklist:10:'com.oracle.java.JavaAppletPlugin':MinimumPlugInBundleVersion" '/System/Library/CoreServices/CoreTypes.bundle/Contents/Resources/XProtect.meta.plist')
FLASH=$(/usr/libexec/PlistBuddy -c "print :PlugInBlacklist:10:'com.macromedia.Flash Player.plugin':MinimumPlugInBundleVersion" '/System/Library/CoreServices/CoreTypes.bundle/Contents/Resources/XProtect.meta.plist')

echo "** XProtect Minimum Versions **"
echo "Flash: $FLASH"
echo "Java: $JAVA"
