#!/bin/bash
. config.properties

# sleep for video render
echo
for i in `seq 3 1`;
do
    echo "Waiting for video render...$i"
    sleep 1
done

# copy video from devices into pc
echo $'\nPulling test videos into pc...'
./adb+.sh pull /sdcard/$VIDEO_DIR results/videos
