#!/bin/bash
#---------------------------------------------------------------------
#  Do application and security updates
#---------------------------------------------------------------------
yum update -y
yum -y install java-1.8.0-openjdk.x86_64
yum -y remove java-1.7.0-openjdk.x86_64
#---------------------------------------------------------------------
# Add a minecraft group and user
#---------------------------------------------------------------------
groupadd -g 501 minecraft
useradd -r -g minecraft -u 2565 -s /bin/bash minecraft
#---------------------------------------------------------------------
# Create the minecraft directory, sync it, chown it to the
# minecraft user, and change dir to the minecraft directory
#---------------------------------------------------------------------
mkdir -p /opt/minecraft/

aws s3 sync s3://000000000000-instance-stores/ProjectEnderDiamond/Latest/ /opt/minecraft/

useradd -r -d /opt/minecraft/mcadmin -g minecraft -u 25565 -s /bin/bash mcadmin
chown -R minecraft:minecraft /opt/minecraft

cd /opt/minecraft/
#---------------------------------------------------------------------
#Launch the minecraft server
#---------------------------------------------------------------------

sudo screen -d -m -S minecraft su -l -c "su -l -c "java -Xms512M -d64 -Xmx12G -XX:MaxPermSize=128M -XX:+UseConcMarkSweepGC -jar /opt/minecraft/spigot-1.11.2.jar" minecraft
