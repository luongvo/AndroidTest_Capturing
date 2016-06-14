#!/bin/bash
. config.properties

# prepare
cur_dir=$(dirname "$0")
cd $cur_dir/../$BASE_DIR

rm -R results
mkdir results
mkdir results/logs
mkdir results/videos

# create log file
exec &> >(tee -a "results/logs/run_standalone.log")

# prepare video folder on devices
./scripts/adb+.sh shell rm -R /sdcard/$BASE_DIR
./scripts/adb+.sh shell mkdir /sdcard/$BASE_DIR
./scripts/adb+.sh shell mkdir /sdcard/$VIDEO_DIR

for device in `adb devices | grep -v "List" | awk '{print $1}'`
do
    # set device
    export ANDROID_SERIAL=$device
    echo
    echo "=== RUNNING ON $device ==="

    # run screenrecord
    echo $'\nScreenrecord is starting...'
    nohup adb -s $device shell screenrecord /sdcard/$VIDEO_DIR/$device$FILE_NAME > /dev/null 2>&1&

    # call test
    echo
    cd ..
    ./test.sh
    cd $BASE_DIR

    # stop screenrecord
    ps | grep "$device shell screenrecord" | grep -v grep | awk '{print $1}' | xargs kill -9
    echo $'\nScreenrecord is stopped...'

    # sleep for video render
    for i in `seq 3 1`; do
        echo "Waiting for video render...$i"
        sleep 1
    done

    # pull test videos into pc
    echo $'\nPulling test videos into pc...'
    adb -s $device pull /sdcard/$VIDEO_DIR results/videos
done

# end
echo
echo "Automate tests results is located at ./$BASE_DIR/results in this repo folder"
