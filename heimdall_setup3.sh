#!/bin/bash
# HEIMDALL: extract prebuilt hev libs from official v2rayNG arm64 APK
set -e
echo "=== HEV EXTRACT START $(date) ==="
cd /tmp
wget -q https://github.com/2dust/v2rayNG/releases/download/2.3.15/v2rayNG_2.3.15_arm64-v8a.apk -O v2.apk
ls -la v2.apk
rm -rf apkx && mkdir apkx
unzip -qo v2.apk -d apkx
ls apkx/lib/arm64-v8a/ || true
# report what native libs the official APK ships
for f in apkx/lib/arm64-v8a/*; do echo "$(basename $f) $(stat -c%s $f)"; done
echo "=== EXTRACT DONE $(date) ==="
