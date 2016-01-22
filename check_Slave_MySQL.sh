#!/bin/sh
MYUSER=root
SOCKET=/var/lib/mysql/mysql.sock 
MYPASS=123456
MYCMD="mysql -u$MYUSER -p$MYPASS -S $SOCKET"
status=($($MYCMD -e "show slave status\G"|egrep "Slave_SQL_Running|Slave_IO_Running|Seconds_Behind_Master|Last_SQL_Errno"|awk '{print $NF}'))

nmap -P0 -p3306 -sS -vv 192.168.1.26|grep 3306 |tail -n1>/tmp/nmap.txt
check_3306=`cat /tmp/nmap.txt|awk '{print $2}'`
service mysqld status &>/dev/null
if [ "$check_3306" != "open" -a $? -ne 0 ]; then
   killall keepalived	
   exit 1
else
  if [ "${status[0]}" = "Yes" -a "${status[1]}" = "Yes" -a "${status[2]}" = 0 ];  then
      echo "MySQL slave is ok!"
      exit 0 
  else
     killall keepalived
     exit 1
  fi
fi
