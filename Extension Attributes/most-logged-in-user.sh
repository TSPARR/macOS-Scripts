#!/bin/bash
# most-logged-in-user.sh
# Grabs the primary user of the current computer

loggedReport=`ac -p`
locpos=2
primaryuser=`echo $loggedReport | awk '{print $1}'`
primarytime=`echo $loggedReport | awk '{print $2}'`

read_next_pair(){
locpos=`expr $locpos + 1`
currentuser=`echo $loggedReport | awk '{print $'$locpos'}'`
locpos=`expr $locpos + 1`
currenttime=`echo $loggedReport | awk '{print $'$locpos'}'`
# Bail out if something goes haywire and awk is returning null values - to avoid infinite loop
if [[ $currentuser = "" ]]; then
exit 1
fi
}

read_next_pair

# While loop to read in values and compare them one by one, keeping the one with the highest time logged in
while [[ $currentuser != total ]]; do
comparetimes=`echo $currenttime $primarytime | awk '{if ($1 > $2) print "True"; else print "False"}'`
if [[ $comparetimes = "True" ]]; then
	primaryuser=$currentuser
	primarytime=$currenttime
fi
read_next_pair
done

echo "<result>$primaryuser</result>"
