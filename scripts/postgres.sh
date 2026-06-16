!#/bin/bash
set -e

echo "Installing PostgreSQL..."
sudo apt-get update
sudo apt-get install -y postgresql postgresql-contrib

echo "Starting PostgreSQL..."
sudo systemctl start postgresql
sudo systemctl enable postgresql

echo "Creating databases and users..."
sudo -u postgres psql <<EOF
CREATE DATABASE n8n_db;
CREATE DATABASE agent_memory_db;
CREATE DATABASE wiki_db;

CREATE USER n8n_user WITH PASSWORD 'secure_password_123';
CREATE USER agent_user WITH PASSWORD 'agent_password_789';
CREATE USER wiki_user WITH PASSWORD 'wiki_password_456';

GRANT ALL PRIVILEGES ON DATABASE n8n_db TO n8n_user;
GRANT ALL PRIVILEGES ON DATABASE agent_memory_db TO agent_user;
GRANT ALL PRIVILEGES ON DATABASE wiki_db TO wiki_user;
EOF

echo "Configuring PostgreSQL to listen on all interfaces..."
sudo sed -i "s/#listen_addresses = 'localhost'/listen_addresses = '*'/" /etc/postgresql/*/main/postgresql.conf

echo "Adding PostgreSQL authentication rules..."
echo "host all all 192.168.0.0/24 md5" | sudo tee -a /etc/postgresql/*/main/pg_hba.conf

echo "Restarting PostgreSQL..."
sudo systemctl restart postgresql

echo "PostgreSQL ready on 192.168.0.110:5432"