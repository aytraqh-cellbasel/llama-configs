#!/bin/bash
# HEIMDALL build env setup — phase 1: JDK + Android cmdline tools
set -e
echo "=== SETUP START $(date) ==="
export DEBIAN_FRONTEND=noninteractive
nproc; free -h | grep Mem; df -h / | tail -1

# 1) JDK 17
if ! command -v java >/dev/null; then
  apt-get update -qq
  apt-get install -y -qq openjdk-17-jdk-headless unzip > /dev/null
fi
java -version 2>&1 | head -1

# 2) Android cmdline-tools
mkdir -p /opt/android-sdk/cmdline-tools
cd /opt/android-sdk/cmdline-tools
if [ ! -d latest ]; then
  wget -q https://dl.google.com/android/repository/commandlinetools-linux-11076708_latest.zip -O /tmp/ct.zip
  unzip -qo /tmp/ct.zip
  mv cmdline-tools latest
fi
export ANDROID_HOME=/opt/android-sdk
export PATH=$ANDROID_HOME/cmdline-tools/latest/bin:$ANDROID_HOME/platform-tools:$PATH

# 3) accept licenses + install SDK pieces
yes | sdkmanager --licenses > /dev/null 2>&1 || true
sdkmanager "platform-tools" "platforms;android-36" "build-tools;36.0.0" > /tmp/sdk_install.log 2>&1
tail -2 /tmp/sdk_install.log
ls $ANDROID_HOME/platforms $ANDROID_HOME/build-tools 2>/dev/null
echo "=== SETUP DONE $(date) ==="
