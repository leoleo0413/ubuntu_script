#!/bin/bash
#
new_pass=$(date +%s | sha256sum | base64 | head -c 20)
echo "mysql: root/${new_pass}" >> server_info.txt

apt-get install -y mariadb-server
systemctl enable mariadb
systemctl start mariadb

mysql_secure_installation <<EOF
${old_pass}
y
${new_pass}
${new_pass}
y
y
y
y
EOF

systemctl daemon-reload
systemctl restart mariadb
systemctl status mariadb

read -n 1 -s -r -p "Press any key to continue"
