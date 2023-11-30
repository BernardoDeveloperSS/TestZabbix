#!/bin/bash
COMMAND=$(/usr/sbin/asterisk -rx"core show channels verbose"|grep ^Agent.*Down|wc -l)

if [ $COMMAND -gt 0 ]; then
        # echo $COMMAND | tr -d -c 0-9
        echo "$COMMAND"
        exit 1
else
	echo "0"
        exit 1
fi
