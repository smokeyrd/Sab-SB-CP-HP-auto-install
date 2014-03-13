#!/bin/bash

clear
echo "THIS INSTALL IS ONLY FOR DEBIAN AND ITS BRANCHES!!!"
echo "This installs SabNZBD, SickBeard, Couchpotato, and Headphones"
echo "Please Hit Enter when the script asks you to hit Enter to add the repos."
echo "Setup will continue in a few seconds."

echo "Please be Patient ...."
sleep 3

if [ $(id -u) != "0" ]; then
    echo "You must be the superuser to run this script" >&2
    exit 1
fi
       
# DISCLAIMER:
# This script is made available to you without any express, implied or 
# statutory warranty, not even the implied warranty of 
# merchantability or fitness for a particular purpose, or the 
# warranty of title. The entire risk of the use or the results from the use of this script remains with you.

userentry()
{
   echo "Enter the name of the NEW user"
   read username
}

passentry()
{
   #check it doesn't already exist
   echo "Enter the password of the new user"
   read userpass
   echo "Re-type the password"
   read retyped
   if [[ $userpass == $retyped ]] ; then finish
   else 
   {
       passentry()
    }
    fi
}

echo "Adding user"
/usr/sbin/useradd -g smbusers -d /home/$username -s /bin/false -m $username
/bin/passwdex $username $userpass



echo "Installing SabNZBD"
sleep 1

mkdir /opt/usenettools
cd /opt/usenettools
git clone git://github.com/sabnzbd/sabnzbd.git
cd sabnzbd
git checkout 0.7.x
cd ..

write_param() {
sed -i "s|$1[[:space:]]*=[[:space:]]*.*|$1=$2|g" $3
write_param SB_USER username /etc/default/sabnzbdplus }

sudo nano /etc/default/sabnzbdplus

echo "SabNZBD Plus has completed Install"
sleep 1

echo "Installing SickBeard..."

#wget https://github.com/midgetspy/Sick-Beard/tarball/master -O sickbeard.tar.gz
#tar xf sickbeard.tar.gz
#mv midgetspy-Sick-Beard-* .sickbeard
#sudo mv .sickbeard/init.ubuntu /etc/init.d/sickbeard
git clone git://github.com/jetskijoe/Sick-Beard.git

echo "Please configure your APP_PATH and $user settings"
sleep 3

#sudo nano /etc/init.d/sickbeard
#sudo update-rc.d sickbeard defaults
#sudo service sickbeard start

echo "Sickbeard has completed Install"
sleep 1

echo "Installing Couchpotato"

#wget https://github.com/RuudBurger/CouchPotatoServer/tarball/master -O couchpotatoserver.tar.gz
#tar xvf couchpotatoserver.tar.gz
#mv RuudBurger-CouchPotatoServer-* .couchpotatoserver
#sudo mv .couchpotatoserver/init/ubuntu /etc/init.d/couchpotato
git clone git://github.com/RuudBurger/CouchPotatoServer.git
cd CouchPotatoServer
git checkout develop
cd ..

echo "Please configure your APP_PATH and $user settings"
sleep 3

#sudo nano /etc/init.d/couchpotato
#sudo chmod +x /etc/init.d/couchpotato
#sudo update-rc.d couchpotato defaults
#sudo service couchpotato start

echo "CouchPotato has completed Install"
sleep 1

echo "Installing Headphones"

#wget https://github.com/rembo10/headphones/tarball/master -O headphones.tar.gz
#tar xvf headphones.tar.gz
#mv rembo10-headphones-* .headphones
#sudo mv .headphones/init.ubuntu /etc/init.d/headphones
#sudo chmod +x /etc/init.d/headphones
git clone git://github.com/jetskijoe/headphones.git

echo "Please configure your APP_PATH and Run_As settings"
sleep 3

sudo nano /etc/init.d/headphones
sudo update-rc.d headphones defaults
sudo service headphones start

echo "Installing nzbToMedia"
cd /opt/usenettools
git clone git://github.com/clinton-hall/nzbToMedia.git
cd nzbToMedia
git checkout dev
cd ..

clear
echo "Install Complete...."
echo "Please see the various vendor websites for help/how to access your server interfaces"
echo "Defaults are as follows:"
echo "SabNZBD Plus: http://localhost:8080"
echo "Sickbeard:  http://localhost:8081"
echo "CouchPotato: http://localhost:5050"
echo "Headphones: http://localhost:8181"
echo "Good Luck."
