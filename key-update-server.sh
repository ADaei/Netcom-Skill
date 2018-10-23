#!/bin/sh

echo "========Create CRT/KEY/PEM Files========"
echo "!!!!!!!!!!!!!!!!Note!!!!!!!!!!!!!!!!"
echo "Common Name SHOULD MATCH Server IP (EX:192.168.56.101)"

sudo rm -f ./*.pem
openssl genrsa 1024 > key.pem
openssl req -new -x509 -key key.pem > crt.pem

echo "Update Server Certification : cwmp.crt/cwmp.key"

sudo rm -f ./genieacs/config/cwmp.*
sudo cp ./crt.pem ./genieacs/config/cwmp.crt
sudo cp ./key.pem ./genieacs/config/cwmp.key
sudo chmod 777 ./genieacs/config/cwmp.*

echo "Generate Client Certification : cwmp.pem"
sudo chmod 777 ./*.pem
cat crt.pem key.pem > cwmp.pem
sudo chmod 777 cwmp.pem

echo "Finish!!"

