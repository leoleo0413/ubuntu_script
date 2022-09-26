#!/bin/bash
#

sysctl -w fs.file-max=12000500
sysctl -w fs.nr_open=20000500
# Set the maximum number of open file descriptors
ulimit -n 20000000

# Set the memory size for TCP with minimum, default and maximum thresholds 
sysctl -w net.ipv4.tcp_mem='10000000 10000000 10000000'

# Set the receive buffer for each TCP connection with minumum, default and maximum thresholds
sysctl -w net.ipv4.tcp_rmem='1024 4096 16384'

# Set the TCP send buffer space with minumum, default and maximum thresholds 
sysctl -w net.ipv4.tcp_wmem='1024 4096 16384'

# The maximum socket receive buffer sizemem_max=16384
sysctl -w net.core.rmem_max=16384
    
# The maximum socket send buffer size
sysctl -w net.core.wmem_max=16384

# https://blog.jayway.com/2015/04/13/600k-concurrent-websocket-connections-on-aws-using-node-js/
sysctl -w net.nf_conntrack_max=1048576


echo "    root soft  nofile  1000000" >> /etc/security/limits.conf
echo "    root hard  nofile  1000000" >> /etc/security/limits.conf
echo "    *    soft  nofile  1000000" >> /etc/security/limits.conf
echo "    *    hard  nofile  1000000" >> /etc/security/limits.conf

read -n 1 -s -r -p "Press any key to continue"
