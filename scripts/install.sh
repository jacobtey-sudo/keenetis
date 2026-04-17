#!/bin/bash

set -e

echo "📦 Installing dependencies..."

apt update
apt install -y python3 python3-pip git openssh-client

echo "📁 Cloning repo..."

git clone https://github.com/YOUR_NAME/router-control-panel.git
cd router-control-panel/backend

echo "🐍 Installing python deps..."
pip3 install -r requirements.txt

echo "⚙️ Creating systemd service..."

cat > /etc/systemd/system/router-api.service <<EOF
[Unit]
Description=Router Control API
After=network.target

[Service]
WorkingDirectory=/root/router-control-panel/backend
ExecStart=/usr/bin/uvicorn app:app --host 0.0.0.0 --port 8000
Restart=always

[Install]
WantedBy=multi-user.target
EOF

echo "🔄 Starting service..."

systemctl daemon-reexec
systemctl enable router-api
systemctl start router-api

echo "✅ DONE"
