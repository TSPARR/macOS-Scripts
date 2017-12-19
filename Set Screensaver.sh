#!/bin/bash
# Set Screensaver.sh
# Sets Screensaver settings for all users

UUID=$(ioreg -rd1 -c IOPlatformExpertDevice | awk '/IOPlatformUUID/ { split($0, line, "\""); printf("%s\n", line[4]); }')
userList=$(dscl . list /Users UniqueID | awk '$2 > 500 {print $1}')

echo "Setting screensaver for the following users..."

for a in $userList ; do
        find /Users -type d -maxdepth 1 -mindepth 1 | grep "$a"
        if [[ $? == 0 ]]; then
        echo -e "$a"
        defaults write /Users/$a/Library/Preferences/ByHost/com.apple.screensaver."$UUID" 'CleanExit' -string "YES"
        defaults write /Users/$a/Library/Preferences/ByHost/com.apple.screensaver."$UUID" 'PrefsVersion' -int "100"
        defaults write /Users/$a/Library/Preferences/ByHost/com.apple.screensaver."$UUID" 'idleTime' -int "600"
        defaults write /Users/$a/Library/Preferences/ByHost/com.apple.screensaver."$UUID" "moduleDict" -dict-add "path" -string "/System/Library/Frameworks/ScreenSaver.framework/Resources/Computer Name.saver"
        defaults write /Users/$a/Library/Preferences/ByHost/com.apple.screensaver."$UUID" "moduleDict" -dict-add "type" -int "0"
        defaults write /Users/$a/Library/Preferences/ByHost/com.apple.screensaver."$UUID" "moduleDict" -dict-add "displayName" -string "Computer Name"
        defaults write /Users/$a/Library/Preferences/ByHost/com.apple.screensaver."$UUID" "moduleDict" -dict-add "moduleName" -string "Computer Name"
        defaults write /Users/$a/Library/Preferences/ByHost/com.apple.screensaver."$UUID" 'showClock' -bool "true"
        defaults write /Users/$a/Library/Preferences/ByHost/com.apple.screensaver."$UUID" 'tokenRemovalAction' -int "0"
        fi
done

echo -e "Setting the default screensaver for the User Template\n"
defaults write /System/Library/User\ Template/Non_localized/Library/Preferences/ByHost/com.apple.screensaver."$UUID" 'CleanExit' -string "YES"
defaults write /System/Library/User\ Template/Non_localized/Library/Preferences/ByHost/com.apple.screensaver."$UUID" 'PrefsVersion' -int "100"
defaults write /System/Library/User\ Template/Non_localized/Library/Preferences/ByHost/com.apple.screensaver."$UUID" 'idleTime' -int "600"
defaults write /System/Library/User\ Template/Non_localized/Library/Preferences/ByHost/com.apple.screensaver."$UUID" "moduleDict" -dict-add "path" -string "/System/Library/Frameworks/ScreenSaver.framework/Resources/Computer Name.saver"
defaults write /System/Library/User\ Template/Non_localized/Library/Preferences/ByHost/com.apple.screensaver."$UUID" "moduleDict" -dict-add "type" -int "0"
defaults write /System/Library/User\ Template/Non_localized/Library/Preferences/ByHost/com.apple.screensaver."$UUID" "moduleDict" -dict-add "displayName" -string "Computer Name"
defaults write /System/Library/User\ Template/Non_localized/Library/Preferences/ByHost/com.apple.screensaver."$UUID" "moduleDict" -dict-add "moduleName" -string "Computer Name"
defaults write /System/Library/User\ Template/Non_localized/Library/Preferences/ByHost/com.apple.screensaver."$UUID" 'showClock' -bool "true"
defaults write /System/Library/User\ Template/Non_localized/Library/Preferences/ByHost/com.apple.screensaver."$UUID" 'tokenRemovalAction' -int "0"
