# AndroidTest_Capturing
Auto capture device screens to video file and pull them into pc local folder when run test on *multiple Android devices*
- `SDCARD` required on test devices
- No `ROOT` required
- Record videos in `mp4` format
- Might apply on both `emulator` and `real device`
- Easy to implement more test mechanism on [test.sh](test.sh) file

## Prepare
- Copy [run_test+record.sh](run_test+record.sh), [test.sh](test.sh), [adb+.sh](adb+.sh) and [adb+nophup.sh](adb+nohup.sh) into your android project repo.
- Config your test mechanism in [test.sh](test.sh).
- Run `./run_test+record.sh` to start the test and record.
- Wait for completed

## Mechanism
- Using [adb+](https://gist.github.com/christopherperry/3208109) to execute `adb command` on all test devices.
- Start [adb screenrecord](https://developer.android.com/studio/command-line/shell.html#screenrecord) before run the test.
- Stop [adb screenrecord](https://developer.android.com/studio/command-line/shell.html#screenrecord) after the test is finished on all devices.
- Test video is located on device `sdcard` folder and `local pc folder`.
