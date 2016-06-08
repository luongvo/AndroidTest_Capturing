#!/usr/bin/env bash
FOLDER_NAME="ANDROID_TEST_VIDEO"
FILE_NAME="screenrecord.mp4"

# video folder
./adb+.sh shell mkdir /sdcard/$FOLDER_NAME
./adb+.sh shell rm -rf /sdcard/$FOLDER_NAME/*

echo
echo 'SCREEN_RECORD IS STARTING...'
./adb+nohub.sh shell screenrecord /sdcard/$FOLDER_NAME/$FILE_NAME

# call test
echo
./test.sh

# test finish, list all nohup processes
echo
echo "screenshot process list"
ps | grep screenrecord
# then kill all
ps | grep screenrecord | grep -v grep | awk '{print $1}' | xargs kill -9
echo
echo 'SCREEN_RECORD IS STOPPED...'
echo "Test video is located at /sdcard/$FOLDER_NAME"

# copy video from devices into pc
mkdir ./$FOLDER_NAME
rm -rf ./$FOLDER_NAME/*
./adb+.sh pull /sdcard/$FOLDER_NAME ./$FOLDER_NAME/

echo "Test video is pulled into ./$FOLDER_NAME"
