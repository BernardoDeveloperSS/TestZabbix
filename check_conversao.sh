#!/bin/bash
WAV=$(grep ^DirectoryWAV= /home/scripts/wav2mp3|cut -d"=" -f2)
MP3=$(grep ^DestinationMP3= /home/scripts/wav2mp3|cut -d"=" -f2)
LASTDAY=$(date -d "-1 day" +"%Y%m%d")

if [ ! -d $WAV ]; then
    echo "1"
    exit 1
fi

if [ ! -d $MP3 ]; then
    echo "1"
    exit 1
fi

TOTALWAV=$(find $WAV/$LASTDAY -name "*.wav" -type f 2>/dev/null|wc -l)
TOTALMP3=$(find $MP3/$LASTDAY -name "*.mp3" -type f 2>/dev/null|wc -l)

if [ $TOTALWAV -eq 0 ] || [ $TOTALMP3 -eq 0 ]; then
    echo "1"
    exit 1
fi

if [ "$TOTALWAV" != "$TOTALMP3" ]; then
    echo "1"
    exit 1
else
    echo "0"
fi
