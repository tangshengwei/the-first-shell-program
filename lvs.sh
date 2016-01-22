#!/bin/sh
# description: Start LVS of Director server
VIP=192.168.60.200
RIP1=192.168.60.132
RIP2=192.168.60.144
. /etc/rc.d/init.d/functions
case "$1" in
    start)
        echo " start LVS of Director Server"
# set the Virtual  IP Address and sysctl parameter
 /sbin/ifconfig eth0:0 $VIP broadcast $VIP netmask 255.255.255.255 up
       echo "1" >/proc/sys/net/ipv4/ip_forward
	   sysctl -p >/dev/null 2>&1
#Clear IPVS table
       /sbin/ipvsadm -C
#set LVS
/sbin/ipvsadm -A -t $VIP:80 -s rr -p 600
/sbin/ipvsadm -a -t $VIP:80 -r $RIP1:80 -g
/sbin/ipvsadm -a -t $VIP:80 -r $RIP2:80 -g
#Run LVS
      /sbin/ipvsadm
       ;;
    stop)
        echo "close LVS Directorserver"
        echo "0" >/proc/sys/net/ipv4/ip_forward
        /sbin/ipvsadm -C
        /sbin/ifconfig eth0:0 down
        ;;
    *)
        echo "Usage: $0 {start|stop}"
        exit 1
esac
