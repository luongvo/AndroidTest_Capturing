#!/usr/bin/env bash
echo 'ANDROID TEST IS RUNNING...'
ADB_INSTALL_TIMEOUT=40 ./gradlew connectedAndroidTest --stacktrace -PdisablePreDex: --daemon
