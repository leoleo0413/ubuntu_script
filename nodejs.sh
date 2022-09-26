#!/bin/bash
#
curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
sudo apt-get install -y nodejs build-essential git

npm install pm2 -g
pm2 startup
