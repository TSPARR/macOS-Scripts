#!/bin/bash
# grepPrintDriver.sh
# Prints a CSV of all printers and their drivers

# Logged in user
USERNAME=$(python -c 'from SystemConfiguration import SCDynamicStoreCopyConsoleUser; import sys; username = (SCDynamicStoreCopyConsoleUser(None, None, None) or [None])[0]; username = [username,""][username in [u"loginwindow", None, u""]]; sys.stdout.write(username + "\n");')

# output file | change as desired
# Filename on /Users/$USERNAME/Desktop
filename=printerdriverinfo.csv

# Create output file with following parameters
if [[ ! -f /Users/$USERNAME/Desktop/$filename ]]; then
echo "Printer Name, Printer Model, Printer Driver, Printer IP" > /Users/"$USERNAME"/Desktop/$filename
fi

# list all printers by name
allPrinters=($(lpstat -a | sed 's/ accepting.*//g'))

# get info for each printer
for eachprinter in "${allPrinters[@]}"
do
# get printer --make-and-model
    printermodel=$(lpoptions -p "$eachprinter" | sed 's/.*printer-make-and-model=//' | sed 's/ printer-state.*//' | sed 's/,.*//' | tr -d \' )
# get printer ip
    printerip=$(lpoptions -p "$eachprinter" | sed 's/.*socket://' | sed 's/finishings.*//' | tr -d //)
# get printer driver
    printerDriverShort=$(lpinfo --make-and-model "$printermodel" -m | awk -F"/" '{print $6}' | sed 's/\.gz.*/.gz/')
        echo "PRINTER INFORMATION"
        echo "Printer Name: $eachprinter"
        echo "Printer Model: $printermodel"
        echo "Printer Driver: $printerDriverShort"
        echo "Printer IP: $printerip"
        echo ""
# output to file
   echo "$eachprinter,$printermodel,$printerDriverShort,$printerip" >> "/Users/$USERNAME/Desktop/$filename"
done

exit 0
