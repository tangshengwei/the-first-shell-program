#########################################################################
# File Name: monitor.sh
# Author: kangrui
# mail: 33750335@qq.com
# Created Time: Sat 28 Nov 2015 01:50:52 PM EST
#########################################################################
#!/bin/bash
resettem=$(tput sgr0)
declare -A ssharray
i=0
number=""

for script_file in `ls -I "monitor.sh" ./`
do
	echo -e "\e[1;35m" "the script:" ${i} '===>' ${resettem} ${script_file}
	ssharray[$i]=${script_file}
	number="${number} | ${i}"
	i=$((i+1))
done
echo ${number}

while true
do
	read -p "please input a number [ ${number} ]:" execshell
	if [[ ! ${execshell} =~ ^[0-9]+ ]];then
		exit 0
	fi
	/bin/sh ./${ssharray[$execshell]}
done
