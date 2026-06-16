# AI Agent DevOps Setup

Complete automated deployment of AI Agent system with n8n, Ollama, PostgreSQL, and Wiki.js using Vagrant.

## Architecture
## Components

- **n8n**: Workflow automation platform
- **Ollama**: Local LLM (mistral:latest - 7B model)
- **PostgreSQL**: Database with chat memory storage
- **Wiki.js**: Documentation and knowledge base

## Prerequisites

- Vagrant 2.x
- VirtualBox 6.x+
- 32GB RAM (16GB minimum)
- 50GB free disk space
- Windows/Mac/Linux

## Quick Start

```bash
# Clone repository
git clone https://github.com/YOUR_USERNAME/AI-Agent-DevOps.git
cd AI-Agent-DevOps

# Start all VMs (takes ~15-20 minutes)
vagrant up

# Check status
vagrant status
```

## Access Points

| Service | URL | Credentials |
|---------|-----|-------------|
| n8n | http://192.168.0.120:5678 | Auto-setup on first run |
| Ollama API | http://192.168.0.130:11434 | No auth |
| Wiki.js | http://192.168.0.140:3000 | admin@wiki.local / password |
| PostgreSQL | 192.168.0.110:5432 | n8n_user / secure_password_123 |

## Features

✅ Fully automated deployment with Vagrant
✅ n8n with Chat Trigger webhook
✅ AI Agent with persistent memory in PostgreSQL
✅ Ollama local LLM (mistral model)
✅ Wiki.js for documentation
✅ Proper network configuration (no Docker routing issues)
✅ WEBHOOK_URL configured correctly

## Database Credentials

| Database | User | Password |
|----------|------|----------|
| n8n_db | n8n_user | secure_password_123 |
| agent_memory_db | agent_user | agent_password_789 |
| wiki_db | wiki_user | wiki_password_456 |

## Workflow

User Input → Chat Trigger → AI Agent → Ollama LLM → PostgreSQL Memory → Response

## Testing

```bash
# SSH into n8n
vagrant ssh n8n

# Check n8n service
sudo systemctl status n8n

# SSH into Ollama
vagrant ssh ollama

# Check Ollama
docker ps | grep ollama

# Test workflow
curl http://192.168.0.120:5678
```

## Troubleshooting

### n8n doesn't connect to PostgreSQL
- Check WEBHOOK_URL in n8n.service
- Verify PostgreSQL is listening on 0.0.0.0:5432
- Check encryption key is set correctly

### Ollama slow response
- mistral:latest is 7B model - takes 10-30s per response
- Larger models available: neural-chat, llama2

### Wiki.js Docker timeout
- Disable VPN if Docker Hub download fails
- Check internet connectivity

## Architecture Details

See `wiki` VM at 192.168.0.140:3000 for full architecture documentation.

## License

MIT

## Author

TimeForLive