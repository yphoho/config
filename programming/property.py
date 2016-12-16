#!/usr/bin/env python

class prty(object):
    def __init__(self, a):
        print "in init"
        self.a=a

    @property
    def geta(self):
        return self.a



hoho=prty(100)
# a=hoho.geta()
a=hoho.geta
print a

