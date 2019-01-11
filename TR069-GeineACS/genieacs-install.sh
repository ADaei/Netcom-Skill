#!/bin/sh

echo "====GenieACS Installation===="
echo "If it is the first Installation, please install following package sequencially."
echo "0. Prequisites and basic components"
echo "1. Ruby"
echo "2. Node.js"
echo "3. Redis"
echo "4. MongoDB"
echo "5. GenieACS"
echo "6. GenieACS-GUI"
echo "Input Option:"

read option

if [ $option -eq 0 ]; then
####Prequisites and basic components
sudo apt-get install g++ zlib1g-dev libssl-dev build-essential openssl libreadline6 libreadline6-dev zlib1g libsqlite3-0 libsqlite3-dev sqlite libxml2 libxml2-dev libxslt-dev autoconf libc6-dev ncurses-dev automake libtool bison subversion tcl git tmux -y

elif [ $option -eq 1 ]; then
####Ruby
sudo tar -zxvf ruby-2.5.1.tar.gz
sudo chmod 777 -R ./ruby-2.5.1
cd ruby-2.5.1
sudo ./configure
sudo make
sudo make install
sudo gem install rails
sudo gem install bundle --pre
cd ..

elif [ $option -eq 2 ]; then
####Node.js
####(Download source code from https://nodejs.org/en/download/)
####sudo apt-get purge --auto-remove nodejs -y
sudo tar -zxvf node-v8.12.0.tar.gz
sudo chmod -R 777 node-v8.12.0
cd node-v8.12.0
sudo ./configure
sudo make
sudo make install
cd ..

elif [ $option -eq 3 ]; then
####Redis
sudo tar -zxvf redis-4.0.11.tar.gz
sudo chmod 777 -R ./redis-4.0.11
cd redis-4.0.11
sudo make
sudo make test
sudo make install
cd ..
sudo mkdir -p /data/db/
sudo mkdir 777 -R /data/db

elif [ $option -eq 4 ]; then
####MongoDB
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10
sudo echo 'deb http://downloads-distro.mongodb.org/repo/ubuntu-upstart dist 10gen' | sudo tee /etc/apt/sources.list.d/mongodb.list
sudo apt-get update
sudo dpkg -i mongodb-org-shell_2.6.12_amd64.deb
sudo dpkg -i mongodb-org-server_2.6.12_amd64.deb
sudo dpkg -i mongodb-org-mongos_2.6.12_amd64.deb
sudo dpkg -i mongodb-org-tools_2.6.12_amd64.deb
sudo dpkg -i mongodb-org_2.6.12_amd64.deb
sudo mkdir -p /data/mongo/
sudo chmod 777 -R /data/mongo

elif [ $option -eq 5 ]; then
####GenieACS
#git clone https://github.com/zaidka/genieacs.git
sudo chmod 777 -R ./genieacs
cd genieacs
#git checkout $(git tag -l v1.1.* --sort=-v:refname | head -n 1)
sudo npm install --unsafe-perm
sudo npm audit fix
sudo npm run compile
cd ..
####Generate Certification Files.
FILE=./genieacs/config/cwmp.key
if [ -f $FILE ]
then
  echo "Certification Files EXIST"
else
  echo "Generate Certification Files ..."
  #rm -f ./genieacs/config/cwmp.key
  #rm -f ./genieacs/config/cwmp.crt
  openssl genrsa 1024 > ./genieacs/config/cwmp.key
  openssl req -new -x509 -key ./genieacs/config/cwmp.key > ./genieacs/config/cwmp.crt
fi

elif [ $option -eq 6 ]; then
####GenieACS-GUI
####git clone https://github.com/zaidka/genieacs-gui
sudo chmod 777 -R ./genieacs-gui
cd genieacs-gui
sudo gem install json -v '1.8.5' --source 'https://rubygems.org/'
bundle update json
bundle install
sudo rails db:migrate RAILS_ENV=development
sudo cp config/graphs-sample.json.erb config/graphs.json.erb
sudo cp config/index_parameters-sample.yml config/index_parameters.yml
sudo cp config/summary_parameters-sample.yml config/summary_parameters.yml
sudo cp config/parameters_edit-sample.yml config/parameters_edit.yml
sudo cp config/parameter_renderers-sample.yml config/parameter_renderers.yml
sudo cp config/roles-sample.yml config/roles.yml
sudo cp config/users-sample.yml config/users.yml
cd ..

else
echo "No Such Option."
fi

