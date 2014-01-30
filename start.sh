#!/bin/bash

# make sure we have a config file 
if [ ! -f /etc/haproxy/haproxy.cfg ]; then
	cp -nR /etc/haproxy.def/* /etc/haproxy/.
fi

# run haproxy
/usr/sbin/haproxy -db -f /etc/haproxy/haproxy.cfg
