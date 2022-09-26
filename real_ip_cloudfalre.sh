#!/bin/bash
#

echo "#Cloudflare ip addresses" > /etc/nginx/cloudflare_ip.conf;
echo "" >> /etc/nginx/cloudflare_ip.conf;

echo "# - IPv4" >> /etc/nginx/cloudflare_ip.conf;
for i in `curl https://www.cloudflare.com/ips-v4`; do
  echo "set_real_ip_from $i;" >> /etc/nginx/cloudflare_ip.conf;
done

echo "" >> /etc/nginx/cloudflare;
echo "# - IPv6" >> /etc/nginx/cloudflare_ip.conf;
for i in `curl https://www.cloudflare.com/ips-v6`; do
  echo "set_real_ip_from $i;" >> /etc/nginx/cloudflare_ip.conf;
done

echo "" >> /etc/nginx/cloudflare;
echo "real_ip_header CF-Connecting-IP;" >> /etc/nginx/cloudflare_ip.conf;

#test configuration and reload nginx
nginx -t && systemctl restart nginx
