#!/bin/bash
set -e

user=`whoami`

if [ "Z$user" != "Znizq" ]
then
    echo "run it as nizq, take first:"
    echo "sudo su nizq"
    exit 1
fi

basedir=/var/www/apt
OPTIONS="-V -b $basedir"

#reprepro $OPTIONS list lucid

sudo echo updating apt......

sudo reprepro $OPTIONS deleteunreferenced

while :
do
    if [ ! -z $1 ]
    then
        changes=`ls | grep "\b$1_.*\.changes"` >/dev/null 2>&1

        echo -e "update $changes"
        echo
        sudo reprepro $OPTIONS remove lucid $1 || true
        reprepro $OPTIONS include lucid $changes

        sudo rm $1_*
        echo -e "\n\n"
    else
        break
    fi

    shift

done

exit 0

