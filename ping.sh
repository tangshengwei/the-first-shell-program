#########################################################################
# File Name: ping.sh
# Author: kangrui
# mail: 33750335@qq.com
# Created Time: Sat 28 Nov 2015 01:13:39 PM EST
#########################################################################
#!/bin/bash
host=192.168.31
for i in `seq 1 254`
do
	ping -c1 -w1 ${host}.${i} >/dev/null 2>&1 
	if [ "$?" -eq "0" ];then
		echo "$host.$i is up"
		echo "$host.$i">>/script/aliave
	else
		echo "$host.$i is down"
	fi
done	
