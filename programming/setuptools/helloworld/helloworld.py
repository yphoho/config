#!/usr/bin/env python

import os, sys


def main(greeting = None):
    if(greeting):
        print greeting
    else:
        print "hello, world."



if __name__ == "__main__":
    main(sys.argv[0])

