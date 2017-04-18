#!/bin/bash
# Call JAMF Helper.sh
# This script will call the JAMF Helper binary to present messages to end users

JAMF_HELPER_PATH="/Library/Application Support/JAMF/bin/jamfHelper.app/Contents/MacOS/jamfHelper"

TITLE="$4"
HEADING="$5"
DESCRIPTION_LINE_1="$6"
DESCRIPTION_LINE_2="$7"
ICON="$8"
BUTTON_1="$9"
BUTTON_2="${10}"
COMMAND="${11}"


MESSAGE="$DESCRIPTION_LINE_1
$DESCRIPTION_LINE_2"

USER_RESPONSE=$("$JAMF_HELPER_PATH" -windowType hud -title "$TITLE" -heading "$HEADING" -description "$MESSAGE" -button1 "$BUTTON_1" -button2 "$BUTTON_2" -defaultButton 1 -cancelButton 2 -icon "$ICON")

if [ "$USER_RESPONSE" == 0 ]; then
    $COMMAND
fi
