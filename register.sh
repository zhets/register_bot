#!/bin/bash
apt update && apt upgrade
apt install python3 python3-pip git
cd /etc/bot
wget -q https://github.com/zhets/register_bot/raw/main/regis.zip
unzip regis.zip
rm -rf regis.zip
pip3 install -r regis/requirements.txt
pip3 install pillow

clear
echo ""
read -e -p "[*] Input your Bot Token : " bottoken
read -e -p "[*] Input Your Id Telegram :" admin
echo -e BOT_TOKEN='"'$bottoken'"' >> /root/regis/var.txt
echo -e ADMIN='"'$admin'"' >> /root/regis/var.txt

cat > /etc/systemd/system/regis.service << END
[Unit]
Description=Simple register - @xdxl_store
After=network.target

[Service]
WorkingDirectory=/etc/bot
ExecStart=python3 -m regis
Restart=always

[Install]
WantedBy=multi-user.target
END
cd

systemctl start regis 
systemctl enable regis

clear
echo " Installations complete, type /menu on your bot"
rm -rf register.sh
