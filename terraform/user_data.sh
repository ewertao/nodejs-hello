#!/bin/bash

# Instala o Docker
yum install docker -y

# Inicia o Docker
systemctl start docker

# Valida o Status do Serviço Docker e salva log
systemctl status docker > /tmp/status-docker.log

# Baixa e executa o script de instalação do k3d
wget -q -O - https://raw.githubusercontent.com/k3d-io/k3d/main/install.sh | bash

# Cria um arquivo deployment.yml em /tmp com as informações do deployment do Kubernetes
cat << EOF > /tmp/deployment.yml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: hello-world
spec:
  replicas: 1
  selector:
    matchLabels:
      app: hello-world
  template:
    metadata:
      labels:
        app: hello-world
    spec:
      containers:
        - name: nodejs
          image: 777156806021.dkr.ecr.eu-central-1.amazonaws.com/hello:${{TAG}}
          ports:
            - containerPort: 8080
          env:
            - name: NODE_ENV
              value: production
---
apiVersion: v1
kind: Service
metadata:
  name: hello-world
spec:
  selector:
    app: hello-world
  ports:
    - protocol: TCP
      port: 80
      targetPort: 8080
EOF

# Cria um novo cluster k3d chamado "mycluster"
k3d cluster create mycluster

# Instala o cURL
yum install curl --skip-broken

# Baixa a versão estável mais recente do kubectl e o instala
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

# Cria uma pasta .kube para o usuário ec2-user
mkdir -p /home/ec2-user/.kube

# Cria uma pasta .kube para o usuário ssm-user
mkdir -p /home/ssm-user/.kube

# Copia o arquivo de configuração kubeconfig para o usuário ec2-user
cp /.kube/config /home/ec2-user/.kube

# Copia o arquivo de configuração kubeconfig para o usuário ssm-user
cp /.kube/config /home/ssm-user/.kube