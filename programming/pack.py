#!/usr/bin/env python

# http://docs.python.org/library/struct.html
import struct

s="hoho"
slen=len(s)

a="nn" + struct.pack('b', slen) + s
print a
print len(a)

a="nn" + struct.pack('h', slen) + s
print a
print len(a)

a="nn" + struct.pack('i', slen) + s
print a
print len(a)

