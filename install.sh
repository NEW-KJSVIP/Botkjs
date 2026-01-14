#!/bin/bash
# FILE: install.sh
# GitHub: https://github.com/yourusername/Botkjs

echo ""
echo "╔══════════════════════════════════════════════════════════╗"
echo "║                🤖 BOTKJS INSTALLATION                    ║"
echo "║           KPJ Auto Bot System - KJS Team 2024           ║"
echo "╚══════════════════════════════════════════════════════════╝"
echo ""

# Check if running as root
if [ "$EUID" -ne 0 ]; then 
    echo "❌ Please run as root or use: sudo bash install.sh"
    exit 1
fi

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

# Log function
log() {
    echo -e "${BLUE}[BOTKJS]${NC} $1"
}

success() {
    echo -e "${GREEN}✓${NC} $1"
}

error() {
    echo -e "${RED}✗${NC} $1"
}

warning() {
    echo -e "${YELLOW}!${NC} $1"
}

# Step 1: Update system
log "Step 1: Updating system packages..."
apt update && apt upgrade -y
success "System updated successfully"

# Step 2: Install Node.js
log "Step 2: Installing Node.js 18.x..."
curl -fsSL https://deb.nodesource.com/setup_18.x | bash -
apt install -y nodejs
success "Node.js $(node --version) installed"

# Step 3: Install Nginx
log "Step 3: Installing Nginx..."
apt install -y nginx
success "Nginx installed"

# Step 4: Create project directory
log "Step 4: Creating project structure..."
mkdir -p /var/www/botkjs
cd /var/www/botkjs

# Step 5: Download files from GitHub
log "Step 5: Downloading Botkjs files..."
wget -q https://raw.githubusercontent.com/yourusername/Botkjs/main/index.html -O index.html
wget -q https://raw.githubusercontent.com/yourusername/Botkjs/main/server.js -O server.js
wget -q https://raw.githubusercontent.com/yourusername/Botkjs/main/package.json -O package.json
success "Files downloaded"

# Step 6: Install dependencies
log "Step 6: Installing Node.js dependencies..."
npm install --silent
success "Dependencies installed"

# Step 7: Configure Nginx
log "Step 7: Configuring Nginx..."
cat > /etc/nginx/sites-available/botkjs << 'EOF'
server {
    listen 80;
    server_name _;
    root /var/www/botkjs;
    index index.html;
    
    # Security headers
    add_header X-Frame-Options "SAMEORIGIN" always;
    add_header X-Content-Type-Options "nosniff" always;
    add_header X-XSS-Protection "1; mode=block" always;
    
    # Frontend
    location / {
        try_files $uri $uri/ /index.html;
        expires 1h;
    }
    
    # Backend API
    location /api {
        proxy_pass http://localhost:3000;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host $host;
        proxy_cache_bypass $http_upgrade;
    }
    
    # Static files
    location ~* \.(js|css|png|jpg|jpeg|gif|ico|svg)$ {
        expires 1y;
        add_header Cache-Control "public, immutable";
    }
}
EOF

ln -sf /etc/nginx/sites-available/botkjs /etc/nginx/sites-enabled/
rm -f /etc/nginx/sites-enabled/default
nginx -t
systemctl restart nginx
success "Nginx configured"

# Step 8: Create systemd service
log "Step 8: Creating systemd service..."
cat > /etc/systemd/system/botkjs.service << 'EOF'
[Unit]
Description=BotKJS - KPJ Auto Bot System
After=network.target

[Service]
Type=simple
User=root
WorkingDirectory=/var/www/botkjs
ExecStart=/usr/bin/node server.js
Restart=on-failure
RestartSec=10
StandardOutput=journal
StandardError=journal
SyslogIdentifier=botkjs

[Install]
WantedBy=multi-user.target
EOF

systemctl daemon-reload
systemctl enable botkjs
systemctl start botkjs
success "Systemd service created"

# Step 9: Configure firewall
log "Step 9: Configuring firewall..."
ufw allow 80/tcp
ufw allow 22/tcp
ufw --force enable
success "Firewall configured"

# Step 10: Create backup script
log "Step 10: Creating backup script..."
cat > /usr/local/bin/backup-botkjs << 'EOF'
#!/bin/bash
BACKUP_DIR="/var/backups/botkjs"
DATE=$(date +%Y%m%d_%H%M%S)
mkdir -p $BACKUP_DIR
cp /var/www/botkjs/kpj_database.db $BACKUP_DIR/kpj_database_$DATE.db
echo "Backup created: $BACKUP_DIR/kpj_database_$DATE.db"
EOF
chmod +x /usr/local/bin/backup-botkjs

# Step 11: Get server IP
IP=$(curl -s ifconfig.me)

echo ""
echo "╔══════════════════════════════════════════════════════════╗"
echo "║                    🎉 INSTALLATION COMPLETE!            ║"
echo "╚══════════════════════════════════════════════════════════╝"
echo ""
echo "📊 APPLICATION INFO:"
echo "   🌐 URL: http://$IP"
echo "   📁 Directory: /var/www/botkjs"
echo "   💾 Database: /var/www/botkjs/kpj_database.db"
echo ""
echo "🔧 MANAGEMENT COMMANDS:"
echo "   Start:  sudo systemctl start botkjs"
echo "   Stop:   sudo systemctl stop botkjs"
echo "   Status: sudo systemctl status botkjs"
echo "   Logs:   sudo journalctl -u botkjs -f"
echo "   Backup: sudo backup-botkjs"
echo ""
echo "⚙️ NEXT STEPS:"
echo "   1. Access http://$IP"
echo "   2. Configure 2Captcha API Key"
echo "   3. Add OSS Token"
echo "   4. Generate KPJ numbers"
echo "   5. Start auto checking"
echo ""
echo "📞 SUPPORT:"
echo "   GitHub: https://github.com/yourusername/Botkjs"
echo "   Issues: https://github.com/yourusername/Botkjs/issues"
echo ""