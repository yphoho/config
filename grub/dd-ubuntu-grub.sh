#!/bin/bash
set -e

outfile=ubuntu.grub
outback=ubuntu.bak

if [ -e $outfile ]; then
    mv $outfile $outback
fi

dd if=/dev/sda6 of=$outfile bs=512 count=1 1>/dev/null 2>&1

# if diff -q retun 1, the file is changed
diff -q $outfile $outback 1>/dev/null 2>&1 || echo "Copy $outfile to Windows 7 !!!"

