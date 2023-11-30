#/bin/bash

for PARTITIONS in $(grep cifs /etc/fstab | awk '{print $2}'); do
        grep $PARTITIONS /proc/mounts >/dev/null || ERRORMSG="$PARTITIONS $ERRORMSG"
done

if [ "$ERRORMSG" ]; then
        echo "1"
else
        echo "0"
fi
