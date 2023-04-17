#!/bin/bash

# Instala o Docker
yum install docker -y

# Inicia o Docker
systemctl start docker

# Valida o Status do Serviço Docker e salva log
systemctl status docker > /tmp/status-docker.log

# Baixa e executa o script de instalação do k3d
wget -q -O - https://raw.githubusercontent.com/k3d-io/k3d/main/install.sh | bash

# Cria um novo cluster k3d chamado "mycluster"
k3d cluster create mycluster

# Instala o cURL
yum install curl --skip-broken

# Baixa a versão estável mais recente do kubectl e o instala
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
./install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

# Cria uma pasta .kube para o usuário ec2-user
mkdir -p /home/ec2-user/.kube

# Cria uma pasta .kube para o usuário ssm-user
mkdir -p /home/ssm-user/.kube

# Copia o arquivo de configuração kubeconfig para o usuário ec2-user
cp /.kube/config /home/ec2-user/.kube

# Copia o arquivo de configuração kubeconfig para o usuário ssm-user
cp /.kube/config /home/ssm-user/.kube