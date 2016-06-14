#!/bin/bash
BASE_DIR="automate-tests"
VIDEO_DIR="$BASE_DIR/videos"
FILE_NAME=".mp4"

# prepare
cur_dir=$(dirname "$0")
cd $cur_dir/../$BASE_DIR

rm -R results
mkdir results
mkdir results/logs
mkdir results/videos

# create log file
exec &> >(tee -a "results/logs/run_test+screenrecord.sh.log")

# prepare video folder on devices
./adb+.sh shell rm -R /sdcard/$BASE_DIR
./adb+.sh shell mkdir /sdcard/$BASE_DIR
./adb+.sh shell mkdir /sdcard/$VIDEO_DIR

echo
echo 'SCREEN_RECORD IS STARTING...'
./adb+nohup.sh "shell screenrecord /sdcard/$VIDEO_DIR" "$FILE_NAME"

# call test
echo
cd ..
./test.sh
cd $BASE_DIR

# test finish, list all nohup processes
echo
echo "screenshot process list"
ps | grep "shell screenrecord"
# then kill all
ps | grep "shell screenrecord" | grep -v grep | awk '{print $1}' | xargs kill -9
echo
echo 'SCREEN_RECORD IS STOPPED...'
echo "Test video is located at /sdcard/$VIDEO_DIR"

# sleep for video render
for i in `seq 3 1`;
do
    echo "Waiting for video render...$i"
    sleep 1
done

# copy video from devices into pc
./adb+.sh pull /sdcard/$VIDEO_DIR results/videos

echo
echo "Automate tests results is located at ./$BASE_DIR/results in this repo folder"
