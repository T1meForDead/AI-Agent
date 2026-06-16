#!/bin/bash
set -e

echo "Installing Node.js 22..."
curl -fsSL https://deb.nodesource.com/setup_22.x | sudo -E bash -
sudo apt-get install -y nodejs build-essential

echo "Node version: $(node --version)"

echo "Installing n8n..."
sudo npm install -g n8n

echo "Getting encryption key from config..."
n8n start &
sleep 5
killall node || true
sleep 2

ENCRYPTION_KEY=$(grep encryptionKey /home/vagrant/.n8n/config | sed 's/.*encryptionKey": "\(.*\)".*/\1/')

echo "Creating n8n systemd service..."
sudo tee /etc/systemd/system/n8n.service > /dev/null <<EOF
[Unit]
Description=n8n
After=network.target

[Service]
Type=simple
User=vagrant
WorkingDirectory=/home/vagrant
Environment=DB_TYPE=postgresdb
Environment=DB_POSTGRESDB_HOST=192.168.0.110
Environment=DB_POSTGRESDB_PORT=5432
Environment=DB_POSTGRESDB_DATABASE=n8n_db
Environment=DB_POSTGRESDB_USER=n8n_user
Environment=DB_POSTGRESDB_PASSWORD=secure_password_123
Environment=N8N_ENCRYPTION_KEY=${ENCRYPTION_KEY}
Environment=N8N_HOST=0.0.0.0
Environment=N8N_PORT=5678
Environment=WEBHOOK_URL=http://192.168.0.120:5678/
Environment=N8N_PROTOCOL=http
Environment=N8N_SECURE_COOKIE=false
ExecStart=/usr/bin/n8n start
Restart=always
RestartSec=10

[Install]
WantedBy=multi-user.target
EOF

echo "Enabling and starting n8n service..."
sudo systemctl daemon-reload
sudo systemctl enable n8n
sudo systemctl start n8n

echo "Waiting for n8n to start..."
sleep 10

echo "n8n ready on 192.168.0.120:5678"