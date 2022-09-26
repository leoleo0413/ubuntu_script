#!/bin/bash
#

read -sp  "Enter swapfile memory:" swap
echo ""

while [[ -z "$swap" ]]; do
	read -p  "Enter swapfile memory:" swap
done

fallocate -l ${swap}G /swapfile
chmod 600 /swapfile
mkswap /swapfile
swapon /swapfile

echo "/swapfile swap swap defaults 0 0" >> /etc/fstab
swapon --show
read -n 1 -s -r -p "Press any key to continue"
