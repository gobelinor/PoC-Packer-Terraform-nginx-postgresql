#!/bin/bash
set -e

echo "=== Mise à jour du système ==="
sudo apt-get update
sudo apt-get upgrade -y

echo "=== Installation des paquets de base ==="
sudo apt-get install -y \
    curl \
    wget \
    git \
    vim \
    htop \
    net-tools \
    software-properties-common \
    apt-transport-https \
    ca-certificates \
    gnupg \
    lsb-release \
    unzip \
    jq

echo "=== Configuration du timezone ==="
sudo timedatectl set-timezone Europe/Paris

echo "=== Configuration de la sécurité de base ==="
# Désactiver root login SSH
sudo sed -i 's/PermitRootLogin yes/PermitRootLogin no/' /etc/ssh/sshd_config

# Configurer le firewall de base
sudo apt-get install -y ufw
sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw allow ssh
sudo ufw --force enable

echo "=== Configuration terminée ==="
