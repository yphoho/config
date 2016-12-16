#!/bin/sh
set -e


slaves=(192.168.1.2 192.168.1.3 192.168.1.4)

for slave in ${slaves[@]}; do
    echo -e "======deal with $slave======"

    echo -e "pull the bind-log to master ...\n"
    rsync -azuCv --delete zdns@${slave}::bind-log /home/zdns/a/bind/chroot/var/log/named/$slave

    echo -e "\n\npush the bind-conf to many slaves ...\n"
    rsync -azuCv --delete /home/zdns/a/bind/chroot/etc/bind/ zdns@${slave}::bind-conf

    echo -e "\n\n"

done

exit 0

