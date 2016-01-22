#########################################################################
# File Name: auto_ftp.sh
# Author: kangrui
# mail: 33750335@qq.com
# Created Time: Sat 28 Nov 2015 08:06:25 PM EST
#ftp bei fen wen jian de moban
#########################################################################
#!/bin/bash
server=127.0.0.1
username=ftp
password="\r"
ftp -i -v -n <<EOF
open $server
user $username $password
cd pub
get a.txt
bye
EOF


