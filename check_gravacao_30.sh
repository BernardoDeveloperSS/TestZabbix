#!/bin/sh
MES=$(date -d "last month" +"%Y%m")
VERIF=$(ls /backup/monitor/ | grep $MES > /tmp/gravacoes)
QUANTIDADE=$(cat /tmp/gravacoes |wc -w)
TOTAL=$(date -d "$(date +%Y-%m-01) -1 day" +%d)

if [ $QUANTIDADE -lt $TOTAL ]; then
    echo "1"
else
    echo "0"
fi
