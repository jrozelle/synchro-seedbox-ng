#!/bin/bash
#
# Synchro-Seedbox-NG
# Author: rsync script by 4r3, install script and PHP by Jedediah, modified by ag0r4n
#
#

CSI="\033["
CEND="${CSI}0m"
CRED="${CSI}1;31m"
CGREEN="${CSI}1;32m"
CYELLOW="${CSI}1;33m"
CBLUE="${CSI}1;34m"

clear

# check user rights
if [ $(id -u) -ne 0 ]
	then
		echo ""
		echo -e "${CRED} This script must be run as root.$CEND" 1>&2
		echo ""
		exit 1
	fi

# logo
echo ""
echo -e "${CBLUE}                                Synchro-Seedbox-NG$CEND"
echo ""
echo -e "${CBLUE}
				  __   __  __   __  
				__)  __)  |  ) (__| 
				                __/ 

$CEND"
echo ""
echo -e "${CYELLOW}          This script is going to install SSNG$CEND"
echo -e "${CYELLOW}            a tool to SYNC your seedbox and your NAS$CEND"
echo ""
echo -e "${CBLUE}        Script rsync par 4r3, script d'installation et php par Jedediah, modifié par ag0r4n$CEND"
echo -e "${CBLUE}              Gros merci à ex_rat et à la communauté mondedie.fr !$CEND"
echo ""


echo -e "${CGREEN}Enter SSDG NAS Username:$CEND"
read NASUSER
echo ""

echo -e "${CGREEN}Enter your NAS hostname/IP address:$CEND"
read NASADDR
echo ""

echo -e "${CGREEN}Enter your NAS port\n(22):$CEND"
read NASPORT
echo ""

echo -e "${CGREEN}Enter your upload speed limit:$CEND"
read SPEED
echo ""

echo -e "${CGREEN}Enter the webpage root dir\n(/var/www):$CEND"
read FOLDERWEB
echo ""

#Création de l'arborescence du script
mkdir -p /usr/local/etc/synchro-seedbox-ng
mkdir -p /var/spool/synchro-seedbox-ng
cp script/ssng /usr/local/bin/
cp config/synchro.conf /usr/local/etc/synchro-seedbox-ng

#Création de l'arborescence de la page web
#cp -R web/* $FOLDERWEB

#Ecriture des variables dans le fichier de configuration
sed -i "s/@nasuser@/$NASUSER/g;" /usr/local/etc/synchro-seedbox-ng/synchro.conf
sed -i "s/@nasaddr@/$NASADDR/g;" /usr/local/etc/synchro-seedbox-ng/synchro.conf
sed -i "s/@nasport@/$NASPORT/g;" /usr/local/etc/synchro-seedbox-ng/synchro.conf
sed -i "s/@speed@/$SPEED/g;" /usr/local/etc/synchro-seedbox-ng/synchro.conf

chmod +x /usr/local/bin/ssng

#write out current crontab
#crontab -l > mycron
#echo new cron into cron file
#echo "* * * * * cd /home/$USER/synchro && ./synchro.sh > /dev/null" >> mycron
#install new cron file
#crontab mycron
#rm mycron

#Suppression des fichiers d'installation
#rm -R /tmp/synchro-seedbox

echo -e "${CBLUE} Thanks ! $CEND"
echo ""
