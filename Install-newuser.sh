#!/bin/bash

clear
echo "THIS INSTALL IS ONLY FOR UBUNTU!!!"
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
   if ($userpass == $retyped)
   {
      finish()
   }
   else 
   {
      passentry()
   }
}

echo "Adding user"
/usr/sbin/useradd -g smbusers -d /home/$username -s /bin/false -m $username
/bin/passwdex $username $userpass



echo "Installing SabNZBD"
sleep 1

apt-get -y install python-software-properties
add-apt-repository ppa:jcfp/ppa
apt-get update
apt-get install -y sabnzbdplus sabnzbdplus-theme-smpl sabnzbdplus-theme-plush sabnzbdplus-theme-iphone

echo "Please configure your APP_PATH and $user settings"
sleep 3

sudo nano /etc/default/sabnzbdplus

echo "SabNZBD Plus has completed Install"
sleep 1

echo "Installing SickBeard..."

wget https://github.com/midgetspy/Sick-Beard/tarball/master -O sickbeard.tar.gz
tar xf sickbeard.tar.gz
mv midgetspy-Sick-Beard-* .sickbeard
sudo mv .sickbeard/init.ubuntu /etc/init.d/sickbeard

echo "Please configure your APP_PATH and $user settings"
sleep 3

sudo nano /etc/init.d/sickbeard
sudo update-rc.d sickbeard defaults
sudo service sickbeard start

echo "Sickbeard has completed Install"
sleep 1

echo "Installing Couchpotato"

wget https://github.com/RuudBurger/CouchPotatoServer/tarball/master -O couchpotatoserver.tar.gz
tar xvf couchpotatoserver.tar.gz
mv RuudBurger-CouchPotatoServer-* .couchpotatoserver
sudo mv .couchpotatoserver/init/ubuntu /etc/init.d/couchpotato

echo "Please configure your APP_PATH and $user settings"
sleep 3

sudo nano /etc/init.d/couchpotato
sudo chmod +x /etc/init.d/couchpotato
sudo update-rc.d couchpotato defaults
sudo service couchpotato start

echo "CouchPotato has completed Install"
sleep 1

echo "Installing Headphones"

wget https://github.com/rembo10/headphones/tarball/master -O headphones.tar.gz
tar xvf headphones.tar.gz
mv rembo10-headphones-* .headphones
sudo mv .headphones/init.ubuntu /etc/init.d/headphones
sudo chmod +x /etc/init.d/headphones

echo "Please configure your APP_PATH and Run_As settings"
sleep 3

sudo nano /etc/init.d/headphones
sudo update-rc.d headphones defaults
sudo service headphones start


clear
echo "Install Complete...."
echo "Please see the various vendor websites for help/how to access your server interfaces"
echo "Defaults are as follows:"
echo "SabNZBD Plus: http://localhost:8080"
echo "Sickbeard:  http://localhost:8081"
echo "CouchPotato: http://localhost:5050"
echo "Headphones: http://localhost:8181"
echo "Good Luck."