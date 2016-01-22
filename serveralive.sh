#########################################################################
# File Name: serveralive.sh
# Author: kangrui
# mail: 33750335@qq.com
# Created Time: Sat 28 Nov 2015 04:25:32 PM EST
# check host is alive's script .
#########################################################################
#!/bin/bash

timestamp=`date +%Y%m%d%H%M%S`
current_index=/var/www/html/index.html
LN=/bin/ln
RM=/bin/rm
Server_list=server_list
mkdir -p /var/www/html/monitor
current_html=/var/www/html/monitor/${timestamp}.html
cat <<EOF >$current_html
<html>
<head>
<title>Server Alive Monitor</title>
</head>

<body>
<table width="50%" border="1" cellpading="1" cellspaceing="0" align="center">
<caption><h2>Server Alive Status</h2></caption>
<tr><th>Server IP</th><th>Server Status</th></tr>
EOF

while read servers
do
	ping -c3 $servers >/dev/null 2>&1
	if [ $? -eq 0 ];then
		STATUS=OK
		COLOR=blue
	else
		STATUS=FALSE
		COLOR=red
	fi
	echo "<tr><td>$servers</td><td><font color=$COLOR>$STATUS</font></td></tr>" >>$current_html
done < $Server_list

cat <<EOF >>$current_html
</table>
</body>
</html>
EOF
$LN -sf $current_html $current_index
	
