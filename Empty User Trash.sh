#!/bin/bash
# Empty User Trash.sh
# Empties the trash for each user in the /Users folder that is (!)not the Shared folder

for dir in /Users/[!Shared]*
do
	# Create a variable with just the users name
	user=$(echo "$dir" | cut -d'/' -f3)

	# Empty each users trash
	rm -rf "$dir"/.Trash/*

	# For logs or viewing progress--shows when the users trash has been emptied
	echo -e "Trash has been emptied for:\t$user"
done
