#!/bin/bash
#

# Detect Debian users running the script with "sh" instead of bash
if readlink /proc/$$/exe | grep -q "dash"; then
	echo "This script needs to be run with bash, not sh"
	exit
fi #

#check root install
if [[ "$EUID" -ne 0 ]]; then
	echo "Sorry, you need to run this as root"
	exit
fi

while :
	do
	clear
	echo 	"Script setup 1 VPS."
	echo	"----------------------------------------"
	echo 	"What do you want to do?"
	echo 	"   1) Update & install basic"
	echo 	"   2) install nodejs"
	echo 	"   3) Install MariaDB"
	echo 	"   4) MariaDB Max Connections"
	echo 	"   5) Install NGINX"
	echo 	"   6) Change port SSH"
	echo 	"   7) sFTP"
	echo 	"   9) Install dotnet core 2.1"
	echo 	"   10) Install redis-server"
	echo 	"   12) Update white list cloudflare"
	echo 	"   13) Node exporter"
	echo 	"   14) Change Swapfile"
	echo 	"   15) TCP Max Connections"
	echo 	"   16) MariaDB Optimation DB"
	echo 	"   17) monogo"

	read -p "Select an option [1-17]: " option

	case $option in
		1)
		apt-get update -y
		timedatectl set-timezone Asia/Ho_Chi_Minh
		timedatectl set-ntp true
		apt-get install git policycoreutils-python-utils -y && reboot
		;;
		2)
		bash <(curl -s http://128.199.172.129/script_ubuntu/nodejs.sh)
		;;
		3)
		bash <(curl -s http://128.199.172.129/script_ubuntu/mariadb.sh)
		;;
		4)
		bash <(curl -s http://128.199.172.129/script_ubuntu/mariadb_max_connections.sh)
		;;
		5)
		bash <(curl -s http://128.199.172.129/script_ubuntu/nginx.sh)
		;;
		6)
		bash <(curl -s http://128.199.172.129/script_ubuntu/sshport.sh)
		;;
		7)
		bash <(curl -s http://128.199.172.129/script_ubuntu/sftp.sh)
		;;
		9)
		bash <(curl -s http://128.199.172.129/script_ubuntu/dotnet.sh)
		;;
		10)
		bash <(curl -s http://128.199.172.129/script_ubuntu/redis-server.sh)
		;;
		12)
		bash <(curl -s http://128.199.172.129/script_ubuntu/real_ip_cloudfalre.sh)
		;;
		13)
		bash <(curl -s http://128.199.172.129/script_ubuntu/node_exporter_016.sh)
		;;
		14)
		bash <(curl -s http://128.199.172.129/script_ubuntu/change_swapfile.sh)
		;;
		15)
		bash <(curl -s http://128.199.172.129/script_ubuntu/tcp_max_connection.sh)
		;;
		16)
		bash <(curl -s http://128.199.172.129/script_ubuntu/optimze_mariadb.sh)
		;;
		17)
		bash <(curl -s http://128.199.172.129/script_ubuntu/mongo_44.sh)
		;;
	esac
done
