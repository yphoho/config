#!/usr/bin/python
# -*- coding: utf-8 -*-


import os, sys, re
import socket


sockfd=socket.socket(socket.AF_INET, socket.SOCK_STREAM)
sockfd.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
sockfd.bind(("127.0.0.1", 9000))
sockfd.listen(3)

while(1):
    cs,ca=sockfd.accept()

    cs.settimeout(120)
    msg=cs.recv(1024)

    print >>sys.stderr, msg
    cs.close()

    # if msg== '1':
    #     connection.send('welcome to server!')
    #     print ca
    #     print msg

    # fname=re.compile("GET\s+([^\s]+)\s+").match(msg).groups()[0]
    # if(fname=="/"):
    #     fname="/index.html"
    # fpathname= os.getcwd()+fname
    # try:
    #     f=open(fpathname,"rb")

    #     cs.send(f.read())
    #     f.close()
    # except(Exception) :
    #     cs.send("\n\n\ncan not find page"+fname+"\n");

    # cs.close()

