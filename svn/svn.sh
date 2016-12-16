svn rm `svn st | grep '^!' | gawk '{print $2}'`
svn add `svn st | grep '^?' | gawk '{print $2}'`

