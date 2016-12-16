#!/bin/sh

for file in *; do
    echo "change $file ..."
    if [ -f $file ]; then
        mv $file `echo "$file" | tr "A-Z" "a-z"`
    fi
done

