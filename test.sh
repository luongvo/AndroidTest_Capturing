#!/usr/bin/env bash
echo 'Remove old report folder...'

rm -rf /app/build/reports
echo 'Remove completed!'

# run test
echo 'Running test...'
ADB_INSTALL_TIMEOUT=40 ./gradlew jacocoTestReport --stacktrace -PdisablePreDex: --daemon
echo 'Run test completed!'

# open report file in browser
open -a "Google Chrome" app/build/reports/androidTests/connected/flavors/DEVELOPMENT/index.html
open -a "Google Chrome" app/build/reports/jacoco/jacocoTestReport/html/index.html
