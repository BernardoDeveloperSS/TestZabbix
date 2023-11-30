#!/bin/bash

pid_length=`pidof -x asterisk|awk '{print length($0)}'`
if [ "$pid_length" == "0" ] || [ "$pid_length" == "" ]; then
	echo "1"
else
	echo "0"
fi
