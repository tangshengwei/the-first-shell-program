#!/bin/bash
master=192.168.1.108
cs=`cat /proc/drbd|grep cs:|awk -F: '{print $3}'|awk '{print $1}'`
ro=`cat /proc/drbd |grep ro:|awk -F/ '{print $2}'|awk '{print $1}'`
while : 
do
ping -c3 -w3 $master >/dev/null 2>&1 
	if [ "$?" -eq "0" ];then
	 if [ $cs == "WFConnection" ];then
	 if [ $ro == "Unknown" ];then
ssh root@$master "[ -f /proc/drbd ]&&drbd_file=cuzai||/etc/init.d/heartbeat stop" >/dev/null 2>&1
	 fi	
	 fi	
	fi
sleep 5
done
