
## 🚀 **CARA INSTALL CEPAT (1 COMMAND)**

```bash
# Login ke VPS, lalu jalankan:
sudo apt update && sudo apt install -y git && git clone https://github.com/your-repo/kpj-bot.git /var/www/kpj-bot && cd /var/www/kpj-bot && chmod +x install.sh && sudo ./install.sh

##⚙️** INSTAL MANUAL**

# Update system
sudo apt update && sudo apt upgrade -y

# Install Node.js
curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
sudo apt install -y nodejs nginx

# Clone project
git clone https://github.com/your-repo/kpj-bot.git /var/www/kpj-bot
cd /var/www/kpj-bot

# Install dependencies
npm install

# Start backend
node server.js

# Configure Nginx (lihat file install.sh)



/var/www/kpj-bot/
├── index.html          # Frontend utama
├── server.js           # Backend API
├── package.json        # Dependencies
├── kpj_database.db     # Database SQLite
├── install.sh          # Installer script
└── node_modules/       # Dependencies