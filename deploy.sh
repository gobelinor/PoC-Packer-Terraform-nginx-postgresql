#!/bin/bash
set -e

echo "🚀 Déploiement Packer + Terraform"
echo "=================================="
echo ""

# Étape 1 : Construire les images Packer
echo "📦 Construction des images Packer..."
cd ./packer

packer init .
packer build -only='openstack.base-ubuntu' .
packer build -only='openstack.web-server' .
packer build -only='openstack.db-server' .
cd -

echo ""
echo "✅ Images Packer construites"
echo ""

# Étape 2 : Déployer avec Terraform
echo "🏗️  Déploiement Terraform..."
cd ./terraform/environments/lab

terraform init
terraform plan
terraform apply -auto-approve

echo ""
echo "✅ Déploiement terminé !"
echo ""
terraform output

