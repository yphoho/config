#!/bin/sh
set -e

for file in *; do
    if [ ! -f $file ]; then
        continue
    fi
    front=${file%%.*}
    ext=`echo ${file##*.} | tr "A-Z" "a-z"`
    newfile=$front.$ext
    mv $file $newfile || true

#    if [ ${file##*.} = "zone" ]; then
#        echo "trim $file..."
#        cut -f1 -d";" $file | sed 's/[\t ]*$//g' > $file.tmp
#        mv $file.tmp $file
#    fi
done

