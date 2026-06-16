Vagrant.configure("2") do |config|
    config.vm.box = "ubuntu/jammy64"

    config.vm.define "postgres" do |postgres|
        postgres.vm.hostname = "postgres"
        postgres.vm.network "public_network", ip: "192.168.0.110"
        postgres.vm.provider "virtualbox" do |vb|
            vb.name = "AI-Agent-PostgreSQL"
            vb.memory = 1024
            vb.cpus = 1
        end
        postgres.vm.provision "shell", path: "scripts/postgres.sh"
    end

    config.vm.define "n8n" do |n8n|
        n8n.vm.hostname = "n8n"
        n8n.vm.network "public_network", ip: "192.168.0.120"
        n8n.vm.provider "virtualbox" do |vb|
            vb.name = "AI-Agent-n8n"
            vb.memory = 4096
            vb.cpus = 2
        end
        n8n.vm.provision "shell", path: "scripts/n8n.sh"
    end
    config.vm.define "ollama" do |ollama|
        ollama.vm.hostname = "ollama"
        ollama.vm.network "public_network", ip: "192.168.0.130"
        ollama.vm.provider "virtualbox" do |vb|
            vb.name = "AI-Agent-Ollama"
            vb.memory = 8192
            vb.cpus = 2
        end
        ollama.vm.provision "shell", path: "scripts/ollama.sh"
    end
    config.vm.define "wiki" do |wiki|
        wiki.vm.hostname = "wiki"
        wiki.vm.network "public_network", ip: "192.168.0.140"
        wiki.vm.provider "virtualbox" do |vb|
            vb.name = "AI-Agent-Wiki"
            vb.memory = 1024
            vb.cpus = 1
        end
        wiki.vm.provision "shell", path: "scripts/wiki.sh"
    end
end

## secure_password_123 - n8n
## secure_password_456 - wiki
## secure_password_789 - agent