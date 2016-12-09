#!/bin/sh
# Geo-IP Location
# Gets an approximation of the computer's current location based on IP

myIP=$(curl -L -s --max-time 10 http://checkip.dyndns.org | egrep -o -m 1 '([[:digit:]]{1,3}\.){3}[[:digit:]]{1,3}')
myLocationInfo=$(curl -L -s --max-time 10 http://ip-api.com/csv/?fields=country,city,lat,lon,/$myIP)

echo "<result>$myLocationInfo</result>"
