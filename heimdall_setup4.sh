#!/bin/bash
# HEIMDALL: stage hev libs + gradle build config + START THE BUILD
set -e
echo "=== BUILD PREP $(date) ==="
cd /workspace/v2rayNG

# 1) stage hev libs where the app expects them (libs/<abi>/)
mkdir -p libs/arm64-v8a
cp /tmp/apkx/lib/arm64-v8a/libhev-socks5-tunnel.so libs/arm64-v8a/
cp /tmp/apkx/lib/arm64-v8a/libhevsockstun.so libs/arm64-v8a/
# copy into the app jniLibs source dir as the CI does (V2rayNG/app/libs)
mkdir -p V2rayNG/app/libs/arm64-v8a
cp /tmp/apkx/lib/arm64-v8a/libhev-socks5-tunnel.so V2rayNG/app/libs/arm64-v8a/
cp /tmp/apkx/lib/arm64-v8a/libhevsockstun.so V2rayNG/app/libs/arm64-v8a/

# 2) local.properties
echo "sdk.dir=/opt/android-sdk" > V2rayNG/local.properties

# 3) gradle wrapper needs java JAVA_HOME
export JAVA_HOME=$(dirname $(dirname $(readlink -f $(which java))))
echo "JAVA_HOME=$JAVA_HOME"

# 4) kick off the build in noprompt mode; arm64-only output implicit via splits
cd V2rayNG
chmod +x gradlew
# run in background so terminal watchdog drops don't kill it
nohup ./gradlew assembleRelease -Pandroid.injected.signing.store.file=/dev/null > /tmp/build.log 2>&1 &
echo "BUILD_PID=$!"
sleep 5
tail -5 /tmp/build.log
echo "=== PREP DONE $(date) ==="
