#!/bin/bash
# Rename Computer.sh
# Author - Encore Technologies
# Author - Tyler Sparr
# This script will rename a computer based on whether it is a laptop or desktop

# This script is provided without warranty or guarantee, and is licensed for use only at the direction of Encore Technologies.
# It is not for distribution. Any application of this script at a customer location is allowed; however,
# use of this script by Encore Technologies or customers of Encore Technologies does not make Encore Technologies
# responsible for any ongoing maintenance of this script.

# Copyright © 2017 Encore Technologies

IS_LAPTOP=$(/usr/sbin/system_profiler SPHardwareDataType | grep "Model Identifier" | grep "Book")
SERIAL=$(ioreg -c IOPlatformExpertDevice -d 2 | awk -F\" '/IOPlatformSerialNumber/{print $(NF-1)}')

if [ "$IS_LAPTOP" != "" ]; then

	echo "Resetting Computer Name to LM$SERIAL"
	/usr/local/bin/jamf setComputerName -name "LM$SERIAL"

else

	echo "Resetting Computer Name to WS$SERIAL"
	/usr/local/bin/jamf setComputerName -name "WS$SERIAL"

fi
