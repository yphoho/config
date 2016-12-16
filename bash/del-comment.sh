#!/bin/sh
set -e

for file in *; do
    # find the file with extent "zone"
    if [ ${file##*.} = "zone" ]; then
        echo "trim $file..."
        cut -f1 -d";" $file | sed 's/[\t ]*$//g' > $file.tmp
        mv $file.tmp $file
    fi
done


http://blogold.chinaunix.net/u/19228/showart.php?id=192128

