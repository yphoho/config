#!/bin/sh
set -e

apps="http://itunes.apple.com/us/app/goodreader-for-ipad/id363448914 http://itunes.apple.com/us/app/prompt/id421507115 http://itunes.apple.com/us/app/issh-ssh-vnc-console/id287765826 http://itunes.apple.com/us/app/reeder/id325502379 http://itunes.apple.com/us/app/reeder-for-ipad/id375661689?mt=8 http://itunes.apple.com/us/app/idaily-pro-hd/id453217344?mt=8"

for app in $apps; do
    # curl $app 2>/dev/null | grep 'class="price"' | gawk -F'>' '{print $4}' | gawk -F'<' '{print $1}'
    echo $app | gawk -F'/' '{print $6}' | tr -d "\n"
    echo -n ": $"
    curl $app 2>/dev/null | grep 'class="price"' | gawk -F'$' '{print $2}' | gawk -F'<' '{print $1}'
done

