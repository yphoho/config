#!/bin/sh
set -e


if [ "$#" -gt 0 ]; then
    root="$1"
else
    root="./"
fi

cd $root
python -m SimpleHTTPServer

