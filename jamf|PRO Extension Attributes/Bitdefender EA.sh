#!/bin/bash
# Bitdefender Folder Size.sh
# Author - Encore Technologies
# Author - Tyler Sparr
# This script will return the size in MB of the Bitdefender folder

# This script is provided without warranty or guarantee, and is licensed for use only at the direction of Encore Technologies.
# It is not for distribution. Any application of this script at a customer location is allowed; however,
# use of this script by Encore Technologies or customers of Encore Technologies does not make Encore Technologies
# responsible for any ongoing maintenance of this script.

# Copyright © 2017 Encore Technologies

echo "<result>$(du -ms /Library/Bitdefender/ | awk '{print $1}')</result>"
