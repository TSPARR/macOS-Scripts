#!/bin/sh
# Service Check.sh
# Lists all running Server.app services

# Create the array
services=( $(sudo serveradmin list) )

# Make the masterloop
for eachService in ${services[@]}; do

  # Check the status of the current service listed in the array
  tc=$(sudo serveradmin status $eachService | grep -io "RUNNING")

  # List all running services
  if [ "$tc" = "RUNNING" ]; then
    echo $i $eachService "(RUNNING)"
  fi
done
