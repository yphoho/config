#!/bin/bash
#


# Check if we are running as root.
if [ $EUID -ne 0 ]
then
	echo "!!!Run it as root, please!!!"
    exit 1
fi



ECHO="echo -e"




iface_file="./interfaces";

mv $iface_file ${iface_file}_bk
touch $iface_file

$ECHO "auto lo\niface lo inet loopback\n" >>$iface_file

$ECHO "auto eth0\niface eth0 inet static" >>$iface_file

while [ -z $address ]
do
    $ECHO "Enter the address:"
    read address
done

$ECHO "address $address" >>$iface_file


while [ -z $netmask ]
do
    $ECHO "Enter the netmask:"
    read netmask
done

$ECHO "netmask $netmask" >>$iface_file


while [ -z $gateway ]
do
    $ECHO "Enter the gateway:"
    read gateway
done

$ECHO "gateway $gateway\n" >>$iface_file


# We set eth1 to 90.90.90.90

$ECHO "auto eth1\niface eth1 inet static" >>$iface_file
$ECHO "address 90.90.90.90" >>$iface_file
$ECHO "netmask 255.255.255.0" >>$iface_file















$ECHO "How many network to listen:"
read nrnet;

$ECHO "\nEnter the network like 192.168.1.90/16."
$ECHO "Enter:"
for((i=0; i<nrnet; i++))
do
    read net[$i]
done


# read -sn1 -p "Press anykey to write the configure file..."
# $ECHO .




filter_file="./filter.bro"

mv $filter_file ${filter_file}_bk
touch $filter_file


networks=""
for((i=0; i<nrnet; i++))
do
    if [ $i != 0 ]
    then
        networks=${networks}" or "
    fi
    networks=${networks}"net ${net[$i]}"
done

networks=$(echo $networks | sed "s/\//\\\\\//g")

sed "s/^ *\[\"detect_server\"\].*,$/    \[\"detect_server\"\] = \"not host $address\",/; s/^ *\[\"network\"\].*,$/    \[\"network\"\] = \"$networks\",/" ${filter_file}_bk >$filter_file






bronado_file="./bronado.conf"
mv $bronado_file ${bronado_file}_bk
touch $bronado_file


networks=""
for((i=0; i<nrnet; i++))
do
    if [ $i != 0 ]
    then
        networks=${networks}","
    fi
    networks=${networks}"${net[$i]}"
done

networks=$(echo $networks | sed "s/\//\\\\\//g")

sed "s/^network *=.*$/network       = $networks/" ${bronado_file}_bk >$bronado_file

