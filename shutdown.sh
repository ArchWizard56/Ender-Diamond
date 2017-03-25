#!/bin/bash
#-----------------------------------------
#this script must be run as root
#this script requires that the essentials plugin be installed
#-----------------------------------------
#------------------------------------------
#define variables
#------------------------------------------
TIME=$1
SCREEN="minecraft"
#------------------------------------------
#If time is now do something special
#------------------------------------------
if [ $TIME == "now" ] || [ $TIME == "Now" ] ; then
	screen -S ${SCREEN} -X stuff "say Server will now shutdown!$(printf \\r)"
	screen -S ${SCREEN} -X stuff "stop$(printf \\r)"
	`sleep 1  
	echo "Sent shutdown command"
	exit 
fi
#-----------------------------------------
#broadcast time remaining
#-----------------------------------------
screen -S ${SCREEN} -X stuff "say Server will shutdown in ${TIME} minutes!$(printf \\r)"
#-----------------------------------------
#shutdown server
#-----------------------------------------
screen -S ${SCREEN} -X stuff "stop$(printf \\r)"

