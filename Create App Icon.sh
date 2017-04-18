#!/bin/sh
# Create App Icon.sh
# This script will pull out an ICNS file from an application, convert it to a PNG, and resize it to 128x128. Designed for creating Self Service icons.

APPDIR=$1
ICON=$(defaults read "$APPDIR/Contents/Info" CFBundleIconFile|sed -e 's/\.icns$//')
ICONFILE="$APPDIR/Contents/Resources/$ICON.icns"
APPNAME=$(basename "$APPDIR" .app)
OUTFILE="$HOME/Desktop/${APPNAME}_icon.png"
/usr/bin/sips -s format png --resampleHeightWidthMax 128 "$ICONFILE" --out "$OUTFILE"
