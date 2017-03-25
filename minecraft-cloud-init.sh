#!/bin/bash
#---------------------------------------------------------------------
#  Set up the instance with all the hardware first
#---------------------------------------------------------------------
export INSTANCE=`echo $(/opt/aws/bin/ec2-metadata --instance-id) | awk ' { print $2 } '`
aws ec2 --region us-west-2 attach-volume --volume-id vol-08dcac7234283f806 --instance-id $INSTANCE --device /dev/xvdb

#---------------------------------------------------------------------
#  Do application and security updates
#---------------------------------------------------------------------
yum update -y
yum -y install java-1.8.0-openjdk.x86_64
yum -y remove java-1.7.0-openjdk.x86_64

#---------------------------------------------------------------------
groupadd -g 501 minecraft
useradd -r -g minecraft -u 2565 -s /bin/bash minecraft


export LINES=`aws ec2 --region us-west-2 describe-volumes --volume-id vol-08dcac7234283f806 --filters Name=attachment.instance-id,Values=$INSTANCE | wc -l`
COUNTER=0
while [ $LINES -lt 4 ] ; do
  echo -n "Attaching "
  date
  sleep 1
  let COUNTER=COUNTER+1
  export LINES=`aws ec2 --region us-west-2 describe-volumes --volume-id vol-08dcac7234283f806 --filters Name=attachment.instance-id,Values=$INSTANCE | wc -l`
  if [ $COUNTER -gt 10 ] ; then
    let LINES=COUNTER
  fi
  echo $COUNTER
done

#---------------------------------------------------------------------
mkdir -p /opt/minecraft
mount /dev/xvdb /opt/minecraft
useradd -r -d /opt/minecraft/mcadmin -g minecraft -u 25565 -s /bin/bash mcadmin
cd /opt/minecraft/Spigot/Latest
#---------------------------------------------------------------------
su -l -c "java -Xms512M -Xmx1G -XX:MaxPermSize=128M -XX:+UseConcMarkSweepGC -jar /opt/minecraft/Spigot/Latest/spigot-1.11.jar" minecraft
