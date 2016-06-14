#!/bin/bash
. config.properties

# prepare
cur_dir=$(dirname "$0")
cd $cur_dir/../$BASE_DIR

rm -R results
mkdir results
mkdir results/logs
mkdir results/videos

# create log
exec &> >(tee -a "results/logs/run_test+screenrecord.sh.log")

# prepare video folder on devices
./adb+.sh shell rm -R /sdcard/$BASE_DIR
./adb+.sh shell mkdir /sdcard/$BASE_DIR
./adb+.sh shell mkdir /sdcard/$VIDEO_DIR

# run screenrecord
echo $'\nScreenrecord is starting...'
./adb+nohup.sh "shell screenrecord /sdcard/$VIDEO_DIR" "$FILE_NAME"
echo

# call test
cd ..
./test.sh
cd $BASE_DIR

# stop screenrecord
ps | grep "shell screenrecord" | grep -v grep | awk '{print $1}' | xargs kill -9
echo $'\nScreenrecord is stopped...'
echo "Test video is located at /sdcard/$VIDEO_DIR"

# pull test videos into pc
./pull_test_videos.sh

# end
echo
echo "Automate tests results is located at ./$BASE_DIR/results in this repo folder"
