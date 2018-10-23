#!/bin/sh

echo "====EasyCWMP Installation===="
echo "If it is the first Installation, please install following package sequencially."
echo "0. Prequisites and basic components"
echo "1. json"
echo "2. libubox"
echo "3. uci"
echo "4. ubus"
echo "5. microxml"
echo "6. easycwmp"
echo "Input Option:"

read option

if [ $option -eq 0 ]; then
####Prequisites and basic components
sudo apt-get install git cmake autoconf automake libtool g++ libcurl4-openssl-dev make curl geany -y

elif [ $option -eq 1 ]; then
####Jason
#git clone git://github.com/json-c/json-c.git
sudo rm -rf ./json-c
tar zxvf json-c.tar.gz
sudo chmod 777 -R ./json-c
cd json-c
sudo autoreconf -i -I ./
sudo ./configure --prefix=/usr
sudo make
sudo make install
sudo ln -sf /usr/include/json-c /usr/include/json

elif [ $option -eq 2 ]; then
####libubox
#git clone git://nbd.name/luci2/libubox.git
tar zxvf libubox.tar.gz
sudo chmod 777 -R ./libubox
cd libubox
sudo cmake CMakeLists.txt -DBUILD_LUA=OFF
sudo make
sudo make install
sudo ln -sf /usr/local/lib/libubox.so /usr/lib/libubox.so
sudo mkdir -p /usr/share/libubox
sudo ln -sf /usr/local/share/libubox/jshn.sh /usr/share/libubox/jshn.sh

elif [ $option -eq 3 ]; then
####uci
#git clone git://nbd.name/uci.git
tar zxvf uci.tar.gz
sudo chmod 777 -R ./uci
cd uci
sudo cmake CMakeLists.txt -DBUILD_LUA=OFF
sudo make
sudo class="western"
sudo make install
sudo ln -sf /usr/local/bin/uci /sbin/uci
sudo ln -sf /usr/local/lib/libuci.so /usr/lib/libuci.so

elif [ $option -eq 4 ]; then
####ubus
#git clone git://nbd.name/luci2/ubus.git
tar zxvf ubus.tar.gz
sudo chmod 777 -R ./ubus
cd ubus
sudo cmake CMakeLists.txt -DBUILD_LUA=OFF
sudo make
sudo make install
sudo ln -sf /usr/local/sbin/ubusd /usr/sbin/ubusd
sudo ln -sf /usr/local/lib/libubus.so /usr/lib/libubus.so

elif [ $option -eq 5 ]; then
####microxml
#git clone https://github.com/pivasoftware/microxml.git
tar zxvf microxml.tar.gz
sudo chmod 777 -R ./microxml
cd microxml
sudo autoconf
sudo ./configure --prefix=/usr --enable-threads --enable-shared --enable-static
sudo make
sudo make install
sudo ln -sf /usr/lib/libmicroxml.so.1.0 /lib/libmicroxml.so
sudo ln -sf /usr/lib/libmicroxml.so.1.0 /lib/libmicroxml.so.1

elif [ $option -eq 6 ]; then
####easycwmp
#wget http://easycwmp.org/download/easycwmp-1.8.0.tar.gz
#wget http://pastebin.lukaperkov.net/openwrt/20121219_lib_functions.sh
#wget http://pastebin.lukaperkov.net/openwrt/20121219_lib_config_uci.sh
#wget http://pastebin.lukaperkov.net/openwrt/20121219_lib_functions_network.sh
sudo mkdir -p /lib/config
sudo mkdir -p /lib/functions
sudo cp 20121219_lib_functions.sh /lib/functions.sh 
sudo cp 20121219_lib_config_uci.sh /lib/config/uci.sh
sudo cp 20121219_lib_functions_network.sh /lib/functions/network.sh
tar -xzvf easycwmp-1.8.0.tar.gz
sudo chmod 777 -R ./easycwmp-1.8.0
cd easycwmp-1.8.0
sudo autoreconf -i -I ./
cd ..
sudo mkdir -p /opt/dev
sudo rm -rf /opt/dev/easycwmp
sudo cp -R easycwmp-1.8.0 /opt/dev/easycwmp
sudo chmod 777 -R /opt/dev
cd /opt/dev/easycwmp/
sudo ./configure --enable-debug --enable-devel --enable-jsonc=1
sudo make
####easycwmp configuration
sudo mkdir -p /usr/share/easycwmp/functions
sudo mkdir -p /etc/easycwmp
sudo ln -sf /opt/dev/easycwmp/ext/openwrt/scripts/easycwmp.sh /usr/sbin/easycwmp
sudo ln -sf /opt/dev/easycwmp/ext/openwrt/scripts/defaults /usr/share/easycwmp/defaults
sudo ln -sf /opt/dev/easycwmp/ext/openwrt/scripts/functions/common/common /usr/share/easycwmp/functions/common
sudo ln -sf /opt/dev/easycwmp/ext/openwrt/scripts/functions/common/device_info /usr/share/easycwmp/functions/device_info
sudo ln -sf /opt/dev/easycwmp/ext/openwrt/scripts/functions/common/management_server /usr/share/easycwmp/functions/management_server
sudo ln -sf /opt/dev/easycwmp/ext/openwrt/scripts/functions/common/ipping_launch /usr/share/easycwmp/functions/ipping_launch
sudo ln -sf /opt/dev/easycwmp/ext/openwrt/scripts/functions/tr181/root /usr/share/easycwmp/functions/root
sudo ln -sf /opt/dev/easycwmp/ext/openwrt/scripts/functions/tr181/ip /usr/share/easycwmp/functions/ip
sudo ln -sf /opt/dev/easycwmp/ext/openwrt/scripts/functions/tr181/ipping_diagnostic /usr/share/easycwmp/functions/ipping_diagnostic
sudo chmod +x /opt/dev/easycwmp/ext/openwrt/scripts/functions/*
sudo mkdir -p /etc/config
sudo ln -sf /opt/dev/easycwmp/ext/openwrt/config/easycwmp /etc/config/easycwmp
sudo ln -sf /opt/dev/easycwmp/bin/easycwmpd /usr/sbin/easycwmpd
export UCI_CONFIG_DIR="/opt/dev/easycwmp/ext/openwrt/config/"
export UBUS_SOCKET="/var/run/ubus.sock"
sudo ln -sf bash /bin/sh

else
echo "No Such Option"
fi

