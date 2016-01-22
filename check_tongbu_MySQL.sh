#!/bin/sh
MYUSER=root
SOCKET=/var/lib/mysql/mysql.sock 
MYPASS=123456
MYCMD="mysql -u$MYUSER -p$MYPASS -S $SOCKET"
errno=(1158 1159 1008 1007 1062)
status=($($MYCMD -e "show slave status\G"|egrep "Slave_SQL_Running|Slave_IO_Running|Seconds_Behind_Master|Last_SQL_Errno"|awk '{print $NF}'))

check_status(){

  if [ "${status[0]}" = "Yes" -a "${status[1]}" = "Yes" -a "${status[2]}" = 0 ];  then
      echo "MySQL slave is ok!"
      sta=0
      return $sta 
  else
     sta=1
     return $sta 
  fi

}
check_errno(){
    check_status
    if [ $? -eq 1 ];then
	for((i=0;i<${#errno[*]};i++))
	   do
	       if [ "${errno[i]}" == "${status[3]}" ];then
		    $MYCMD -e "stop slave;"
		    $MYCMD -e "set global sql_slave_skip_counter=1"
		    $MYCMD -e "start slave;"
               fi
	   done		
     fi
}
check_again(){
	status=($($MYCMD -e "show slave status\G"|egrep "Slave_SQL_Running|Slave_IO_Running|Seconds_Behind_Master|Last_SQL_Errno"|awk '{print $NF}'))

	check_status >/dev/null 2&>1
        if [ $? -eq 1 ];then
	    echo "MySQL slave is fail $(date +%F)" >/tmp/haha.log
            mail -s "MySQL slave is fail date" </tmp/haha.log
	fi
	
}
main(){
        while :
        do
	     check_errno
	     check_again
            sleep 30
        done
}
main
