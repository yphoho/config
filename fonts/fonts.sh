#!/bin/sh
set -e

sudo mkfontscale
sudo mkfontdir
sudo fc-cache -fv


# list the fonts installed
fc-list
# list the chinese fonts
fc-list :lang=zh

