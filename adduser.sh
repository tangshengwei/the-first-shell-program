#########################################################################
# File Name: adduser.sh
# Author: kangrui
# mail: 33750335@qq.com
# Created Time: Fri 22 Jan 2016 09:07:46 AM EST
#qu sui ji shu de ji zhong fang fa
#mi ma shi 8 wei shu:
#1.echo $RANDOM |md5sum |cut -c2-9
#2.openssl rand -base64 8
#3.date +%s%N |cut -c 10-18
#4.head /dev/urandom |cksum|cut -c 1-8
#5.cat /proc/sys/kernel/random/uuid |cut -c 1-8
#6.yum -y install expect
#  mkpasswd -l 8
#########################################################################
#!/bin/bash
. /etc/init.d/functions
[ ! $UID -eq 0 ] && {
	echo "only allow root to this cmd."
    exit
}
for n in `seq -w 10`
do
	pass=`echo $RANDOM|md5sum|cut -c 2-9`
	echo $pass
	useradd kangrui$n &>/dev/null&&\
	echo $pass|passwd --stdin kangrui$n &>/dev/null
	if [ $? -eq 0 ];then
		action "useradd kangrui$n success!"   /bin/true
	else
		action "useradd kangrui$n false!"   /bin/false
	fi
	echo -e "kangrui$n\n$pass" >>/user.txt
done
