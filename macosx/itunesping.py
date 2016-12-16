#!/usr/bin/env python

import os, sys
import threading
import operator


def get_domain_name():
    suffix="phobos.apple.com"
    a="a"

    dlist=[]
    for i in range(1, 2000):
        dn=a + str(i) + '.' + suffix
        dlist.append(dn)

    return dlist



def ping_worker(dlist):
    # print dlist
    global g_mutex, g_rtt

    pingrtt={}
    for item in dlist:
        cmd="ping -nc 2 %s | tail -n 1" % (item)
        p=os.popen(cmd)
        rtt=p.readline().strip()
        p.close()
        avg=rtt.split('/')[4]
        # print item, avg

        # # the point is irrelative
        # avg=int(float(avg))
        pingrtt[item]=avg


    g_mutex.acquire()
    g_rtt.update(pingrtt)
    g_mutex.release()

    return 0




if __name__ == "__main__":
    global g_mutex, g_rtt
    g_mutex=threading.Lock()
    g_rtt={}

    
    num_threads=100
    # num_threads=2
    tid=[]

    dlist=get_domain_name()
    dlistlen=len(dlist)
    work_per_thread=float(dlistlen)/num_threads
    for i in range(num_threads):
        start=int(i * work_per_thread)
        end=int((i+1) * work_per_thread)
        t=threading.Thread(target=ping_worker, args=(dlist[start:end], ))
        t.start()
        tid.append(t)

    if (i+1)*work_per_thread < dlistlen:
        start=int((i+1) * work_per_thread)
        t=threading.Thread(target=ping_worker, args=(dlist[start:], ))
        t.start()
        tid.append(t)


    for t in tid:
        t.join()


    # print g_rtt, len(g_rtt)
    for key, value in sorted(g_rtt.iteritems(),
                             key=operator.itemgetter(1),
                             reverse=True):
        print key, value



