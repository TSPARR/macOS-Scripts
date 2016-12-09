#!/bin/bash
# Get Computer Profile Names.sh
# Gets all current profiles installed on the computer

profiles -C -v | awk -F: '/attribute: name/{print $NF}' | sort | nl -w 2 -s " "

profiles -L -v | awk -F: '/attribute: name/{print $NF}' | sort | nl -w 2 -s " "
