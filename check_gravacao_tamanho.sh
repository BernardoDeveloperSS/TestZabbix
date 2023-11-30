#!/bin/bash

result="$(cat /tmp/result_grav)"
if [ "$result" = "OK" ]; then
    echo "0"
else
    echo "1"
fi
