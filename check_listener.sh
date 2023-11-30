#!/bin/bash

if service listener status >/dev/null 2>&1; then
    echo "0"
else
    echo "1"
fi
