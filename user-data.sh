#!/bin/bash
# Update and install required packages
apt-get update -y

mkdir -p /folder1 /folder2

cat << 'EOF' > /usr/local/bin/move-files.sh
#!/bin/bash
while true; do
    mv /folder1/* /folder2/ 2>/dev/null
    sleep 5
done
EOF

chmod +x /usr/local/bin/move-files.sh

cat << 'EOF' > /root/setup-systemd.sh
#!/bin/bash
cat << 'EOL' > /etc/systemd/system/move-files.service
[Unit]
Description=Move files from /folder1 to /folder2
After=network.target

[Service]
ExecStart=/usr/local/bin/move-files.sh
Restart=always
User=root

[Install]
WantedBy=multi-user.target
EOL

# Reload systemd, enable, and start the service
systemctl daemon-reload
systemctl enable move-files.service
systemctl start move-files.service
EOF

chmod +x /root/setup-systemd.sh
echo "/root/setup-systemd.sh" >> /etc/rc.local

chmod +x /etc/rc.local


