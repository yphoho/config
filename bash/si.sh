#/bin/sh
set -e


si_dir=`readlink -f ./`
src_dir=$si_dir/../src

cd $src_dir
if [ -f $si_dir/GTAGS ]; then
    export GTAGSROOT=$src_dir GTAGSDBPATH=$si_dir
    global -u && htags -d $si_dir $si_dir
else
    htags -g -d $si_dir $si_dir
fi
cd $si_dir

find ./HTML -name "*.html" -exec \
    sed -i '\:</head>: i\<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />' {} \;

