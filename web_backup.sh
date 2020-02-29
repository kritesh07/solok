#!/bin/bash
HOST="localhost"
short_host=`hostname -s`
long_host=`hostname`
#IP="`wget -q -O - http://169.254.169.254/latest/meta-data/public-ipv4`"
#PVT_IP="Hostname=`wget -q -O - http://169.254.169.254/latest/meta-data/local-ipv4`"
#s3bucket=shadows3priopass

export path1=/data01/backups/web_backups
#export path2=/s3backups/"$short_host"_$IP/web_backups
date1=`date +%y%m%d_%H%M%S`


/usr/bin/find $path1/* -type d -mtime +2 -exec rm -r {} \; 2> /dev/null
mkdir $path1/$date1
cd /
cp -r /var/www/html $path1/
cd $path1/html
for i in */; do /bin/tar -zcvf "$path1/$date1/${i%/}.tar.gz" "$i"; done
if [ $? -eq 0 ] ; then 
        rm -r $path1/html
fi
cd /
cp -r $path1/$date1 $path2/
#rm -r /data01/tmp/$s3bucket/"$short_host"_$IP/web_backups/*

/home/som/monitor.sh 99 | tee /home/som/web_backup_report >> /home/web_monthly_backup_report
cat /home/som/web_backup_report | #mail -s "backup_report of $long_host ($IP) " -r $short_host@mitainfotech.in support@mitainfotech.com
sh -c "sync; echo 3 > /proc/sys/vm/drop_caches"