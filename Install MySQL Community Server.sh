#!/bin/sh
# Install MySQL Community Server.sh
# Grabs the latest version of MySQL 5.6 from their site, installs it, and adds it to the PATH

LoggedOnUser=$(logname)

curl -L -o /tmp/mysql-5.6.32-osx10.8-x86_64.dmg "https://dev.mysql.com/get/Downloads/MySQL-5.6/mysql-5.6.32-osx10.8-x86_64.dmg"
hdiutil mount -nobrowse /tmp/mysql-5.6.32-osx10.8-x86_64.dmg
installer -pkg /Volumes/mysql-5.6.32-osx10.8-x86_64/mysql-5.6.32-osx10.8-x86_64.pkg -target /
hdiutil unmount "/Volumes/mysql-5.6.32-osx10.8-x86_64"
rm /tmp/mysql-5.6.32-osx10.8-x86_64.dmg

echo 'export PATH="/usr/local/mysql/bin:$PATH"' >> /Users/$LoggedOnUser/.bash_profile

echo 'export PATH="/usr/local/mysql/bin:$PATH"' >> /System/Library/User\ Template/Non_localized/.bash_profile
