#!/bin/bash
#
read -p  "Enter username:" username
echo ""

while [[ -z "$username" ]]; do
	read -p  "Enter username:" username
done

password=$(date +%s | sha256sum | base64 | head -c 20)

groupadd sftpusers
useradd -G sftpusers -s /sbin/nologin ${username}
passwd ${username} <<EOF
${password}
${password}
EOF
echo "upload: ${username}/${password}" >> server_info.txt

chown root:sftpusers -R /opt
chmod 755 -R /opt

sed -i '116 s/.*/Subsystem sftp internal-sftp/g' /etc/ssh/sshd_config

echo "
Match Group sftpusers
	ChrootDirectory /opt
	ForceCommand internal-sftp
	AllowTcpForwarding no
	X11Forwarding no">> /etc/ssh/sshd_config

systemctl restart sshd

read -n 1 -s -r -p "Press any key to continue"
