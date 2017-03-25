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
BUCKET="ykcdxelbza-instance-stores/ProjectEnderDiamond/Latest/"
MINECRAFTLOCATION="/opt/minecraft"
#------------------------------------------
#If time is now do something special
#------------------------------------------
if [ $TIME == "now" ] || [ $TIME == "Now" ] ; then
	screen -S ${SCREEN} -X stuff "say Server will now shutdown!$(printf \\r)"
	sleep 5  
        screen -S ${SCREEN} -X stuff "stop$(printf \\r)"
        echo "Sent shutdown command"
	sleep 7
	echo "Starting s3 sync"
	aws s3 sync ${MINECRAFTLOCATION} s3://${BUCKET}
	echo "s3 sync finished!"
	exit 
fi
#-----------------------------------------
#broadcast time remaining
#-----------------------------------------
screen -S ${SCREEN} -X stuff "say Server will shutdown in ${TIME} minutes!$(printf \\r)"
#----------------------------------------
#Sleep until time expires
#----------------------------------------
timeToSleep=$(($TIME * 60))
echo "Sleeping for ${timeToSleep} seconds"
sleep $timeToSleep
#-----------------------------------------
#shutdown server
#-----------------------------------------
screen -S ${SCREEN} -X stuff "stop$(printf \\r)"
echo "Sent shutdown command"
sleep 7
echo "Starting s3 sync"
aws s3 sync ${MINECRAFTLOCATION} s3://${BUCKET}
echo "s3 sync finished!"


