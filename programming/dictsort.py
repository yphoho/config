#!/usr/bin/env python

import operator


d = {1:2, 3:4, 4:3, 2:1, 0:0}
sorted_x = sorted(d.iteritems(), key=operator.itemgetter(1))
print sorted_x

sorted_x = sorted(d.items(), key=lambda x: x[1])
print sorted_x

