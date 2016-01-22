#!/bin/sh
BAKPATH=/server/backup
MYUSER=root
SOCKET=/var/lib/mysql/mysql.sock 
MYPASS=123456
MYCMD="mysql -u$MYUSER -p$MYPASS -S $SOCKET"
MYDUMP="mysqldump -u$MYUSER -p$MYPASS -S $SOCKET -x -B -F -R"
[ ! -d $BAKPATH ] && mkdir -p $BAKPATH
DBLIST=`$MYCMD -e "show databases;"|sed 1d|egrep -v "information_schema|mysql"`
for dbname in $DBLIST
do
   $MYDUMP $dbname|gzip >$BAKPATH/${dbname}_$(date +%F).sql.gz
done
