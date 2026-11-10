#!/bin/bash
set -e
APK=/workspace/v2rayNG/V2rayNG/app/build/outputs/apk/fdroid/release/v2rayNG_2.3.15-fdroid_arm64-v8a.apk
if [ -z "$GH" ]; then echo "NO_GH_TOKEN"; exit 1; fi
curl -s -X POST -H "Authorization: token $GH" -H "Content-Type: application/vnd.android.package-archive" --data-binary @"$APK" "https://uploads.github.com/repos/aytraqh-cellbasel/llama-configs/releases/440109455/assets?name=v2rayNG_2.3.15-heimdall_arm64-v8a.apk" -o /tmp/up_result.json
head -c 300 /tmp/up_result.json
echo
echo UPLOADED
