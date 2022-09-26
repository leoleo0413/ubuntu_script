#!/bin/bash
#
apt-get install redis -y

echo "
port 10001
requirepass @@@abcd-1234
databases 32
daemonize yes">>/etc/redis/redis_server.conf

systemctl start redis
systemctl enable redis
systemctl status redis

redis-server /etc/redis/redis_server.conf
redis-cli ping

read -n 1 -s -r -p "Press any key to continue"

