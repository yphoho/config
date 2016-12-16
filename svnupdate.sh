#!/bin/sh
#set -e

gameover=`dirname $0`/.gameover

update_project()
{
    local dir=$1

    local rv=0
    cd "$dir"
    if [ -d .svn ]; then
        echo  "svn update $dir..."
        svn update
        rv=$?
    elif [ -d .git ]; then
        echo "git pull $dir..."
        git pull
        rv=$?
    elif [ -d .hg ]; then
        echo "hg update $dir..."
        hg update
        rv=$?
    fi
    cd ..

    if [ "$rv" -ne 0 ]; then
        echo "\033[31m $dir update error !!! \033[0m"
        echo "$dir" >>"$gameover"
    else
        echo
    fi
}

rm -f "$gameover"
for dir in *; do
    if [ -L "$dir" ]; then
        continue
    fi
    if [ -d "$dir" ]; then
        update_project $dir &
    fi
done

wait

