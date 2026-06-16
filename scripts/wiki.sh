#!/bin/bash
set -e

echo "Installing Docker..."
sudo apt-get update
sudo apt-get install -y docker.io
sudo systemctl start docker
sudo systemctl enable docker

echo "Starting Wiki.js container..."
docker run -d \
  --name wiki \
  --restart=always \
  --network host \
  -e DB_TYPE=postgres \
  -e DB_HOST=192.168.0.110 \
  -e DB_PORT=5432 \
  -e DB_NAME=wiki_db \
  -e DB_USER=wiki_user \
  -e DB_PASS=wiki_password_456 \
  ghcr.io/requarks/wiki:2

echo "Waiting for Wiki.js to start..."
sleep 10

echo "Wiki.js ready on 192.168.0.140:3000"