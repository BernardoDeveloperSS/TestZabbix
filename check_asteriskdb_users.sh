#!/bin/bash
FALHA=$(sqlite3 /var/lib/asterisk/astdb.sqlite3 "select substr(key,10,4),count(*) total from astdb where key like '/AMPUSER%' and key not like '%cidname%' group by substr(key,10,4)"|grep -v "|17$"|awk -F"|" '{if(NR>0 && $2<17)printf "%d ",$1}END{if(NR>0 && $2<17) print ""}')

if [ "$FALHA" ]; then
    echo "$FALHA"
else
    echo "0"
fi
