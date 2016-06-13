#!/usr/bin/env bash
FOLDER_NAME="ANDROID_TEST_VIDEO"
FILE_NAME=".mp4"

# prepare video folder
# device
./automate-tests-resources/adb+.sh shell mkdir /sdcard/$FOLDER_NAME
./automate-tests-resources/adb+.sh shell rm -rf /sdcard/$FOLDER_NAME/*
# local pc
mkdir ./$FOLDER_NAME
rm -rf ./$FOLDER_NAME/*

echo
echo 'SCREEN_RECORD IS STARTING...'
./automate-tests-resources/adb+nohup.sh "shell screenrecord /sdcard/$FOLDER_NAME" "$FILE_NAME"

# call test
echo
./test.sh

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
./automate-tests-resources/adb+.sh pull /sdcard/$FOLDER_NAME ./$FOLDER_NAME/

echo "Test video is pulled into ./$FOLDER_NAME"
