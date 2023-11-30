#!/bin/bash
if [ $(date +"%w") -ne 1 ]; then
    DIAS=2
else
    DIAS=3
fi

DIR=($(find /var/spool/asterisk/monitor -mindepth 1 -maxdepth 1 -type d -mtime +$DIAS ! -name "amd" "flac" "lost+found"   2>/dev/null|cut -d"/" -f6|paste -d: -))
if [ ${#DIR[@]} -gt 0 ]; then
    echo "CRITICAL. Verificar conversões dos dias (${DIR[@]})"
else
    echo "0"
fi
