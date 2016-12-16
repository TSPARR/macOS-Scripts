#!/bin/bash
# Set DHCP Client ID.sh
# Sets the DHCP Client ID on all network interfaces

IFS=$'\t\n'

clientID="Empty"

interfaces=$(networksetup -listallnetworkservices)

for ((i = 1; i < ${#interfaces[@]}; i++))
do
	networksetup -setdhcp "${interfaces[$i]}" "$clientID"
done
