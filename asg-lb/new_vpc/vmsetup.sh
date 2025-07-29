#!/bin/bash
#cloud-config

apt-get update -y
apt-get install apache2 -y

systemctl enable apache2
systemctl start apache2

PRIVATE_IP=$(hostname -I | awk '{print $1}')

PUBLIC_IP=$(curl -s http://checkip.amazonaws.com)

cat <<EOF > /var/www/html/index.html
<!DOCTYPE html>
<html>
<head>
    <title>VM IP Information</title>
</head>
<body>
    <h1>Welcome to your VM!</h1>
    <p><strong>Private IP:</strong> $PRIVATE_IP</p>
    <p><strong>Public IP:</strong> $PUBLIC_IP</p>
</body>
</html>
EOF
