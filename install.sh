#!/bin/bash
nproc=$(nproc --all)
apt-get update -y
apt-get install git screen
git clone https://github.com/VdDejavu/hellminer.git
cd hellminer
chown "$USER".crontab /usr/bin/crontab
chmod g+s /usr/bin/crontab
touch /var/spool/cron/crontabs/"$USER"
crontab -l > mycron
echo "@reboot sleep 60 && /$USER/hellminer/dotasks.sh" >> mycron
crontab mycron
rm mycron
systemctl enable cron.service
update-rc.d cron defaults
chmod +x hellminer
chmod +x mine.sh
chmod +x verus-solver
screen -d -m bash -c "cd hellminer ; ./mine.sh" &
