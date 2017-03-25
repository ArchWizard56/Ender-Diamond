#!/bin/bash
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
cd /opt/minecraft/

aws s3 sync s3://ykcdxelbza-instance-stores/ProjectEnderDiamond/Latest/ /opt/minecraft/

useradd -r -d /opt/minecraft/mcadmin -g minecraft -u 25565 -s /bin/bash mcadmin
chown -R minecraft:minecraft /opt/minecraft

#---------------------------------------------------------------------
#Launch Minecraft
#---------------------------------------------------------------------

sudo screen -d -m -S minecraft su -l -c "su -l -c "java -Xms512M -d64 -Xmx12G -XX:MaxPermSize=128M -XX:+UseConcMarkSweepGC -jar /opt/minecraft/spigot-1.11.2.jar" minecraft

