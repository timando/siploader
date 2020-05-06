#!/usr/bin/python
import sys
import itertools
import socket
import time
import math
import random

def get_duration(acd,stdev):
        return abs(random.normalvariate(float(acd)*1000,float(stdev)*1000))
def loadgen(number,acd,cps,stdev):
        delay=1.0/float(cps)
        socket=open_socket('127.0.0.1', 8021, 'ClueCon')
        for i in itertools.count():
                duration=get_duration(acd,stdev)
                send_call(socket,number,duration)
                time.sleep(delay)

def send_call(socket, number, duration):
        options="{origination_caller_id_number=12345,ignore_early_media=true}"
        message="bgapi originate {options}sofia/gateway/testgateway/{number} load_{duration} XML custom".format(options=options, number=number, duration=int(duration))
        send_message(socket,message)

def open_socket(ip, port, password):
        sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        sock.connect((ip, port))
        send_message(sock, "auth {}".format(password))
        return sock

def send_message(socket, message):
        socket.send(message+"\r\n\r\n")
        print(message)
        return socket.recv(4096)


if len(sys.argv) < 5:
        print("Usage: {} numberstart numberend acd cps stdev".format(sys.argv[0]))
        sys.exit()

number=sys.argv[1]
acd=sys.argv[2]
cps=sys.argv[3]
stdev=sys.argv[4]

loadgen(number,acd,cps,stdev)
#ssh "root@$fshostname" python3 /tmp/loadgen.py "$numberstart" "$numberend" "$acd" "$cps" "$stdev"

