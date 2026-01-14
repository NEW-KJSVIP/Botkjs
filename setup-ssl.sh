#!/bin/bash
# SSL Setup for BotKJS

DOMAIN="your-domain.com"
EMAIL="admin@$DOMAIN"

# Install Certbot
apt install -y certbot python3-certbot-nginx

# Get SSL certificate
certbot --nginx -d $DOMAIN --non-interactive --agree-tos -m $EMAIL

# Auto-renewal
echo "0 0,12 * * * root python3 -c 'import random; import time; time.sleep(random.random() * 3600)' && certbot renew -q" | tee -a /etc/crontab > /dev/null

echo "✅ SSL setup complete for $DOMAIN"