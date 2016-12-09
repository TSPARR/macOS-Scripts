#!/bin/bash
# Create UTC Configuration File.sh
# Creates the preferences file to point Universal Type Client to a specific server

touch /Library/Preferences/com.extensis.UniversalTypeClient.conf
echo server.address=$1 >> /Library/Preferences/com.extensis.UniversalTypeClient.conf
echo server.port=8080 >> /Library/Preferences/com.extensis.UniversalTypeClient.conf
