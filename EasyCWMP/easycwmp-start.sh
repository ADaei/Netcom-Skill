#!/bin/sh
set -x #echo on

# Set client config
sudo cp client.conf /etc/config/easycwmp

# Set certification file
sudo rm -f /etc/ssl/certs/cwmp.pem
sudo cp ./cwmp.pem /etc/ssl/certs/

# Start easycwmp daemon
sudo /usr/sbin/ubusd -s /var/run/ubus.sock &
sudo /usr/sbin/easycwmpd -f -b

echo "==== press Ctrl+C to terminate ===="
