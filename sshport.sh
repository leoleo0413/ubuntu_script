#!/bin/bash
#
read -p  "Enter new user:" username
echo ""

while [[ -z "$username" ]]; do
	read -p  "Enter new user:" username
done

read -p  "Enter new port:" port
echo ""

while [[ -z "$port" ]]; do
	read -p "Enter new port:" port
done

password=$(date +%s | sha256sum | base64 | head -c 20)

useradd ${username} -s /bin/bash -m
passwd ${username} <<EOF
${password}
${password}
EOF
echo "${username}/${password}" >> server_info.txt

sed -i '15 s/.*/Port '"${port}"'/g' /etc/ssh/sshd_config
sed -i '34 s/.*/PermitRootLogin no/g' /etc/ssh/sshd_config

systemctl restart sshd
read -n 1 -s -r -p "Press any key to continue"
