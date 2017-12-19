#!/bin/bash
# Add Users to LPAdmin Group.sh
# Author - Encore Technologies
# Author - Tyler Sparr
# This script will add all users to the lpadmin group on the computer.

# This script is provided without warranty or guarantee, and is licensed for use only at the direction of Encore Technologies.
# It is not for distribution. Any application of this script at a customer location is allowed; however,
# use of this script by Encore Technologies or customers of Encore Technologies does not make Encore Technologies
# responsible for any ongoing maintenance of this script.

# Copyright © 2017 Encore Technologies

/usr/sbin/dseditgroup -o edit -n /Local/Default -a everyone -t group lpadmin
