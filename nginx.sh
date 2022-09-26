#!/bin/bash
#

apt-get install nginx -y

bash <(curl -s http://128.199.172.129/script_ubuntu//real_ip_cloudfalre.sh);

wget "http://128.199.172.129/script_ubuntu//nginx.conf"

yes | cp nginx.conf /etc/nginx/nginx.conf

systemctl start nginx
systemctl enable nginx
systemctl status nginx

read -n 1 -s -r -p "Press any key to continue"
