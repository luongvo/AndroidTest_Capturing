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
exec &> >(tee -a "results/logs/run_multi.log")

# prepare video folder on devices
./scripts/adb+.sh shell rm -R /sdcard/$BASE_DIR
./scripts/adb+.sh shell mkdir /sdcard/$BASE_DIR
./scripts/adb+.sh shell mkdir /sdcard/$VIDEO_DIR

# run screenrecord
echo $'\nScreenrecord is starting...'
./scripts/adb+nohup.sh "shell screenrecord /sdcard/$VIDEO_DIR" "$FILE_NAME"
echo

# call test
cd ..
./test.sh
cd $BASE_DIR

# stop screenrecord
ps | grep "shell screenrecord" | grep -v grep | awk '{print $1}' | xargs kill -9
echo $'\nScreenrecord is stopped...'

# sleep for video render
for i in `seq 3 1`; do
    echo "Waiting for video render...$i"
    sleep 1
done

# pull test videos into pc
echo $'\nPulling test videos into pc...'
./scripts/adb+.sh pull /sdcard/$VIDEO_DIR results/videos

# end
echo
echo "Automate tests results is located at ./$BASE_DIR/results in this repo folder"
