# 🤖 BotKJS - KPJ Auto Bot System

![Banner](https://files.catbox.moe/c9i4h3.png)

## 🚀 **CARA INSTALL CEPAT (1 COMMAND)**
# Login ke VPS, lalu jalankan:
```
sudo apt update && sudo apt install -y git && git clone https://github.com/your-repo/kpj-bot.git /var/www/kpj-bot && cd /var/www/kpj-bot && chmod +x install.sh && sudo ./install.sh
```

##⚙️** INSTAL MANUAL**

# Update system
```
sudo apt update && sudo apt upgrade -y
```
# Install Node.js
```
curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
sudo apt install -y nodejs nginx
```
# Clone project
```
git clone https://github.com/your-repo/kpj-bot.git /var/www/kpj-bot
cd /var/www/kpj-bot
```
# Install dependencies
```
npm install
```
# Start backend
```
node server.js
```
# Configure Nginx (lihat file install.sh)



![GitHub](https://img.shields.io/github/license/yourusername/Botkjs)
![GitHub stars](https://img.shields.io/github/stars/yourusername/Botkjs)
![GitHub forks](https://img.shields.io/github/forks/yourusername/Botkjs)


#📁 ***STRUKTUR POLDER***

├── 📄 index.html          # ✅ WAJIB - Frontend utama
├── 📄 server.js           # ✅ WAJIB - Backend API
├── 📄 package.json        # ✅ WAJIB - Dependencies
├── 📄 README.md           # ✅ WAJIB - Documentation
├── 📄 .gitignore          # ✅ WAJIB - Git ignore
├── 📄 LICENSE             # ✅ WAJIB - License
├── 📄 install.sh          # ✅ WAJIB - Installer
├── 📄 deploy.sh           # ✅ OPSIONAL - One-click deploy
├── 📄 .env.example        # ✅ OPSIONAL - Config template
├── 📁 scripts/            # ✅ OPSIONAL - Utility scripts
├── 📁 docs/               # ✅ OPSIONAL - Documentation
└── 📁 examples/           # ✅ OPSIONAL - Examples