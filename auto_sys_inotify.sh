#!/bin/sh
SRC=/var/www/html/
DST=root@192.168.31.150:/var/www/html

inotifywait -mrq -e create,move,modify,delete,attrib $SRC |while read A B C
do
	rsync -ahqzt --delete $SRC $DST
done
