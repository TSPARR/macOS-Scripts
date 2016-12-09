#!/bin/bash
# ARD Login Script.sh
# After editing the username and password fields below, the script when run through ARD will login multiple computers to the same account

# Login Script to log in multiple computers with ARD from the login screen.
osascript -e 'tell application "System Events" to keystroke "username"'
osascript -e 'tell application "System Events" to keystroke tab'
osascript -e 'tell application "System Events" to delay 0.5'
osascript -e 'tell application "System Events" to keystroke "password"'
osascript -e 'tell application "System Events" to keystroke return'
