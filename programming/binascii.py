#!/usr/bin/env python

import binascii

wire="abcdefg\x01\xff11"
print binascii.b2a_hex(wire)

