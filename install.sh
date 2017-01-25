#!/bin/bash
wget https://github.com/Optiminer/OptiminerZcash/raw/master/optiminer-zcash-1.5.0.tar.gz
tar -xvf optiminer-zcash-1.5.0.tar.gz
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
(sudo crontab -l; echo "@reboot /bin/sleep 60 && /home/george/optiminer-zcash/mine.sh" ) | sudo crontab -

