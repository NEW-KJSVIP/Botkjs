#!/bin/bash
# FILE: deploy.sh
# One-click deployment script

echo "🚀 BotKJS Deployment Script"
echo "=============================="

# Check internet connection
if ! ping -c 1 google.com &> /dev/null; then
    echo "❌ No internet connection"
    exit 1
fi

# Download and run installer
echo "📥 Downloading installer..."
wget -q https://raw.githubusercontent.com/yourusername/Botkjs/main/install.sh -O /tmp/botkjs-install.sh

echo "🔧 Running installer..."
chmod +x /tmp/botkjs-install.sh
sudo bash /tmp/botkjs-install.sh

echo "✅ Deployment completed!"