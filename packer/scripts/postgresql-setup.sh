#!/bin/bash
set -e

echo "=== Installation de PostgreSQL ==="
sudo apt-get update
sudo apt-get install -y postgresql postgresql-contrib

echo "=== Configuration de PostgreSQL ==="
# Configurer PostgreSQL pour écouter sur toutes les interfaces
sudo sed -i "s/#listen_addresses = 'localhost'/listen_addresses = '*'/" /etc/postgresql/*/main/postgresql.conf

# Ajouter une règle d'authentification pour les connexions réseau
echo "host    all             all             0.0.0.0/0               md5" | sudo tee -a /etc/postgresql/*/main/pg_hba.conf

# Configurer le firewall pour PostgreSQL
sudo ufw allow 5432/tcp

echo "=== Optimisation des paramètres PostgreSQL ==="
sudo tee -a /etc/postgresql/*/main/postgresql.conf > /dev/null <<'EOF'

# Optimisations
shared_buffers = 256MB
effective_cache_size = 1GB
maintenance_work_mem = 64MB
checkpoint_completion_target = 0.9
wal_buffers = 16MB
default_statistics_target = 100
random_page_cost = 1.1
effective_io_concurrency = 200
work_mem = 4MB
min_wal_size = 1GB
max_wal_size = 4GB
EOF

echo "=== Redémarrage de PostgreSQL ==="
sudo systemctl restart postgresql
sudo systemctl enable postgresql

echo "=== Vérification du statut ==="
sudo systemctl status postgresql --no-pager

echo "=== Configuration PostgreSQL terminée ==="
echo "Note: N'oubliez pas de créer un utilisateur et une base de données après le déploiement"
