#!/usr/bin/env python
# -*- coding: utf-8 -*-

import sys
import smtplib
from email.mime.text import MIMEText


def send_mail(to_list, sub, content):
    mail_host = 'smtp.163.com'
    mail_user = 'xxxx@163.com'
    mail_pass = 'xxxx'
    mail_postfix = '163.com'

    me = mail_user + '<' + mail_user + '@' + mail_postfix + '>'
    msg = MIMEText(content)
    msg['Subject'] = sub
    msg['From'] = me
    msg['To'] = to_list

    try:
        s = smtplib.SMTP()
        s.set_debuglevel(1)
        s.connect(mail_host)
        s.login(mail_user, mail_pass)
        s.sendmail(me, to_list, msg.as_string())
        s.close()
        return True
    except Exception, e:
        print e
        return False


if __name__ == '__main__':
    mailto_list = sys.argv[1]
    sub = sys.argv[2]
    content = sys.stdin.read()

    if send_mail(mailto_list, sub, content):
        print 'send success'
    else:
        print 'send failed'
