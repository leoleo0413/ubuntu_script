#!/bin/bash
#
wget https://packages.microsoft.com/config/ubuntu/20.10/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
sudo dpkg -i packages-microsoft-prod.deb
apt-get update 
apt-get install -y apt-transport-https dotnet-sdk-2.1 supervisor

cp /etc/supervisor/supervisord.conf /etc/supervisor/supervisord.conf.bak

echo "
[inet_http_server]
port=*:9001
">> /etc/supervisor/supervisord.conf


systemctl start supervisor
systemctl enable supervisor
systemctl status supervisor



read -n 1 -s -r -p "Press any key to continue"
