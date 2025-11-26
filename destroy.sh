#!/bin/bash
set -e

echo "🗑️  Destruction de l'infrastructure..."
cd ./terraform/environments/lab

terraform destroy -auto-approve

echo ""
echo "✅ Infrastructure détruite"
