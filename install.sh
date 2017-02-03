#!/bin/bash
wget -O /home/george/optiminer-zcash-1.6.0.tar.gz https://github.com/Optiminer/OptiminerZcash/blob/master/optiminer-zcash-1.6.0.tar.gz
tar -xvf /home/george/optiminer-zcash-1.6.0.tar.gz -C /home/george
echo "#!/bin/bash
export GPU_FORCE_64BIT_PTR=1
POOL=zstratum+tls://us1-zcash.flypool.org:3443
USER=t1JCTyzYgqufiATXM2HjfiobPKnNZxpXX5a.$HOSTNAME
PASSWORD=x
cd \"\$(dirname \"\$0\")\"
while true
do
  ./optiminer-zcash -s \$POOL -u \$USER -p \$PASSWORD --watchdog-timeout 30 --watchdog-cmd \"./watchdog-cmd.sh\"
  if [ \$? -eq 134 ]
  then
    break
  fi
done" > /home/george/optiminer-zcash/mine.sh
chmod +x /home/george/optiminer-zcash/mine.sh
echo "GPU_FORCE_64BIT_PTR=1" >> /etc/environment
echo "GPU_MAX_ALLOC_PERCENT=95" >> /etc/environment
(sudo crontab -l; echo "@reboot /bin/sleep 60 && /home/george/optiminer-zcash/mine.sh" ) | sudo crontab -
sudo reboot
