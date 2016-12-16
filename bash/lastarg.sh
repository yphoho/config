#!/bin/sh

# http://blog.morebits.org/?p=103

# only available in bash
# echo ${!#}

eval last=\${$#}
echo $last

