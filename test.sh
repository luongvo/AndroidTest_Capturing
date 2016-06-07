#!/usr/bin/env bash
FOLDER_NAME="ANDROID_TEST_VIDEO"
FILE_NAME="screenrecord.mp4"

# PREPARE
# list of devices
adb devices

# video folder
adb shell mkdir /sdcard/$FOLDER_NAME
adb shell rm -rf /sdcard/$FOLDER_NAME/*

# START CAPTURE AND RUN TEST
echo 'SCREEN_RECORD IS STARTING...'
cmd="adb shell screenrecord /sdcard/$FOLDER_NAME/$FILE_NAME"
#$cmd & pid=$!
#PID_LIST+=" $pid";

echo 'ANDROID TEST IS RUNNING...'
cmd="./gradlew connectedAndroidTest --stacktrace -PdisablePreDex: --daemon"
$cmd & pid=$!
PID_LIST+=" $pid";

trap "kill $PID_LIST" SIGINT
wait $pid

# FINISH
echo 'ANDROID TEST IS COMPLETED!'
echo "Test video is located at /sdcard/$FOLDER_NAME/$FILE_NAME"
