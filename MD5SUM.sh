#########################################################################
# File Name: md5sum_check_bin/sbin.sh
# Author: kangrui
# mail: 33750335@qq.com
# Created Time: Sat 28 Nov 2015 08:55:39 PM EST
#########################################################################
#!/bin/bash
PATH="/script/*"
FIND=/usr/bin/find
MD5=/usr/bin/md5sum
RM=/bin/rm
LUJING=/script/md5
$FIND $PATH -type f -exec $MD5 {} \; >$LUJING
#$RM -rf /1.txt
#$RM -rf $LUJING
