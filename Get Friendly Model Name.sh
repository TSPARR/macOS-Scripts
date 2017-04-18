#!/bin/bash
# Get Friendly Model Name.sh
# Retrieves a more user friendly model name i.e. MacBook Pro (Retina, 13-inch, Mid 2014) vs MacBookPro11,1

curl -s http://support-sp.apple.com/sp/product?cc="$(system_profiler SPHardwareDataType | awk '/Serial/ {print $4}' | cut -c 9-)" | sed 's|.*<configCode>\(.*\)</configCode>.*|\1|'
