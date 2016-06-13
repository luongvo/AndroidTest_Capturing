#!/usr/bin/env bash
BASE_DIR="automate-tests"
FOLDER_NAME="ANDROID_TEST_VIDEO"
FILE_NAME="_screenrecord.mp4"

# prepare
cur_dir=$(dirname "$0")
cd $cur_dir/../$BASE_DIR

mkdir results
rm -rf results/*
mkdir results/logs
mkdir results/videos

# create log file
exec &> >(tee -a "results/logs/run_test+screenrecord.sh.log")

# prepare video folder on devices
./adb+.sh shell mkdir /sdcard/$FOLDER_NAME
./adb+.sh shell rm -rf /sdcard/$FOLDER_NAME/*

echo
echo 'SCREEN_RECORD IS STARTING...'
./adb+nohup.sh "shell screenrecord /sdcard/$FOLDER_NAME" "$FILE_NAME"

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
echo "Test video is located at /sdcard/$FOLDER_NAME"

# sleep for video render
for i in `seq 5 1`;
do
    echo "Waiting for video render...$i"
    sleep 1
done

# copy video from devices into pc
./adb+.sh pull /sdcard/$FOLDER_NAME results/videos

echo
echo "Automate tests results is located at ./$BASE_DIR/results in this repo folder"
