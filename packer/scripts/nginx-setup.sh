#!/bin/bash
set -e

echo "=== Installation de Nginx ==="
sudo apt-get update
sudo apt-get install -y nginx

echo "=== Configuration de Nginx ==="
# Créer un utilisateur dédié pour les applications web
sudo useradd -r -s /bin/false webuser || true

# Créer les répertoires pour les sites web
sudo mkdir -p /var/www/html
sudo chown -R www-data:www-data /var/www/html

# Configurer le firewall pour HTTP/HTTPS
sudo ufw allow 'Nginx Full'

echo "=== Création d'une page de test ==="
sudo tee /var/www/html/index.html > /dev/null <<'EOF'
<!DOCTYPE html>
<html>
<head>
    <title>Web Server Ready</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            max-width: 800px;
            margin: 50px auto;
            padding: 20px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
        }
        h1 { font-size: 2.5em; }
        .info {
            background: rgba(255,255,255,0.1);
            padding: 20px;
            border-radius: 10px;
            margin-top: 20px;
        }
    </style>
</head>
<body>
    <h1>Web Server Ready!</h1>
    <div class="info">
        <p><strong>Server:</strong> Nginx</p>
        <p><strong>Image:</strong> Built with Packer</p>
        <p><strong>Status:</strong> Ready for deployment</p>
    </div>
</body>
</html>
EOF

echo "=== Activation et démarrage de Nginx ==="
sudo systemctl enable nginx
sudo systemctl start nginx

echo "=== Vérification du statut ==="
sudo systemctl status nginx --no-pager

echo "=== Configuration Nginx terminée ==="
