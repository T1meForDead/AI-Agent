#!/bin/bash
set -e

echo "Installing Docker..."
sudo apt-get update
sudo apt-get install -y docker.io
sudo systemctl start docker
sudo systemctl enable docker
sudo usermod -aG docker vagrant

echo "Installing Ollama..."
docker pull ollama/ollama:latest

echo "Starting Ollama container..."
docker run -d \
  --name ollama \
  --restart=always \
  -p 11434:11434 \
  ollama/ollama:latest

echo "Waiting for Ollama to start..."
sleep 5

echo "Pulling mistral model..."
docker exec ollama ollama pull mistral:latest

echo "Ollama ready on 192.168.0.130:11434"