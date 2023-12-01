#!/bin/bash

if service listener status > /dev/null; then
    echo "1"
else
    echo "0"
fi
