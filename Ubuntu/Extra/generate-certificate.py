#*-coding:utf-8-*-
# author: BBBBear

import shlex
import subprocess
import logging
import os

f = open("./Extra/command.txt")
line = f.readline()
num = 0
mkdirCmd = "mkdir -p /usr/local/ca"
subprocess.run(''.join(mkdirCmd), shell=True)
while line:
    line = f.readline()
    if num == 7:
        os.chdir('/usr/local/ca/')
        logging.warning("attention check your ip!")
        cmd="ifconfig"
        gotIP = subprocess.getstatusoutput(cmd)
        print(gotIP)
        subprocess.run(''.join(line), shell=True)
        num += 1
    elif num == 22:
        os.chdir('/usr/local/ca/')
        gotStatus = subprocess.getstatusoutput(line)
        print(gotStatus)
        num += 1
    else:
        os.chdir('/usr/local/ca/')    
        subprocess.run(''.join(line), shell=True)
        num += 1
f.close()
