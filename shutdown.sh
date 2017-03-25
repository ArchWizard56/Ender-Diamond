#!/bin/bash
#-----------------------------------------
#this script must be run as root
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
	screen -S minecraft -X stuff "broadcast Server will now shutdown!$(printf \\r)"
	sleep 1
fi

