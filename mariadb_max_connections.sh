#!/bin/bash
#

echo "
[mysqld]
symbolic-links=0

open_files_limit=12000
max_connections=100000
event_scheduler=on
innodb_file_per_table=1
log_bin_trust_function_creators=1" >> /etc/mysql/mariadb.conf.d/50-server.cnf

echo "mysql soft nofile 4096" >> /etc/security/limits.conf
echo "mysql hard nofile 10240" >> /etc/security/limits.conf

mkdir -p /etc/systemd/system/mariadb.service.d

cat > /etc/systemd/system/mariadb.service.d/limits.conf <<EOF
[Service]
LimitNOFILE=infinity
EOF

systemctl daemon-reload
systemctl restart mariadb
read -n 1 -s -r -p "Press any key to continue"
