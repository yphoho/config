#!/usr/bin/env python

import os, sys
import json
import dns.message, dns.query, dns.tsigkeyring

import binascii

from scapy.all import *




# resp=sr1(IP(dst="8.8.8.8")/UDP()/DNS(rd=1,qd=DNSQR(qname="www.baidu.com")))
# resp.show()
# hexdump(resp)

# a=sniff(filter="udp and port 53", count=2)
# a.nsummary()
# a[0].show()



query=dns.message.make_query("www.baidu.com", "A")
# query.set_opcode(dns.opcode.IQUERY) # for zipper
# print query.to_text()

wire=query.to_wire()
# view="view1"
# lview=len(view)
# wire += chr(lview) + view
# print binascii.b2a_hex(wire)

# print dns.message.from_wire(wire) # convert to a Message obj
# resp=dns.query.udp(query, "8.8.8.8", None, 53)


conf.L3socket = L3RawSocket
srcip=["203.119.80.180", "0.0.0.0", "1.1.1.1", "255.250.255.256"]
dnsserver="localhost"

for ip in srcip:
    pa=IP(src=srcip, dst=dnsserver)/UDP(sport=[9264], dport=[53,])/wire
    send(pa)



