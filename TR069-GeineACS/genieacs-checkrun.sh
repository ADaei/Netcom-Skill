#!/bin/sh

#sudo pkill redis-server
#sudo pkill mongod
#sudo pkill node

sudo ps -ae | grep redis
sudo ps -ae | grep mongo
sudo ps -ae | grep node
sudo netstat -ntlp | grep redis
sudo netstat -ntlp | grep mongo
sudo netstat -ntlp | grep node
sudo netstat -ntlp | grep 3000

