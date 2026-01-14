#!/bin/bash
# FILE: scripts/update.sh
# Tempat: Botkjs/scripts/

echo "🔄 Updating BotKJS..."

cd /var/www/botkjs

# Backup current database
if [ -f "kpj_database.db" ]; then
    cp kpj_database.db "kpj_database.backup.$(date +%Y%m%d)"
fi

# Pull latest changes
git pull origin main

# Update dependencies
npm install

# Restart service
sudo systemctl restart botkjs

echo "✅ Update completed!"