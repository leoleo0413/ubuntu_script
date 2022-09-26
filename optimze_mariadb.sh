#!/usr/bin/bash
#

read -sp  "Enter root password:" password
echo ""

while [[ -z "$password" ]]; do
	read -sp  "Enter root password:" password
done



rm -rf /root/backup && mkdir /root/backup

systemctl stop mariadb && cp -ra /var/lib/mysql mysqldata && systemctl start mariadb && systemctl status mariadb

mysqldump --routines --events --flush-privileges --all-databases  --user=root --password="$password" > /root/backup/all-db.sql
mysql -e --user=root --password="$password" "SELECT DISTINCT CONCAT ('DROP DATABASE ',TABLE_SCHEMA,' ;') FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA <> 'mysql' AND TABLE_SCHEMA <> 'information_schema';" | tail -n+2 > /root/backup/drop.sql
mysql --user=root --password="$password" < /root/backup/drop.sql

systemctl stop mariadb
rm /var/lib/mysql/ibdata1 && rm /var/lib/mysql/ib_logfile0 && rm /var/lib/mysql/ib_logfile1
systemctl start mariadb
systemctl status mariadb
mysql --user=root --password="$password" < /root/backup/all-db.sql
mysql_upgrade --force

read -n 1 -s -r -p "Press any key to continue"