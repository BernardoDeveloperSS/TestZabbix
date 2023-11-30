#!/bin/bash
COMANDO=$(asterisk -rx'manager show connected'|grep 'dss\>' | wc -l)
echo "$COMANDO"
