#!/bin/bash
# HEIMDALL: clone v2rayNG + fetch libv2ray.aar + hev-libs
set -e
echo "=== CLONE START $(date) ==="
cd /workspace
if [ ! -d v2rayNG ]; then
  git clone --depth 1 https://github.com/2dust/v2rayNG.git
fi
cd v2rayNG
# libv2ray.aar (Xray core for Android via JNI)
mkdir -p V2rayNG/app/libs
if [ ! -f V2rayNG/app/libs/libv2ray.aar ]; then
  wget -q https://github.com/2dust/AndroidLibXrayLite/releases/download/v26.10.31/libv2ray.aar -O V2rayNG/app/libs/libv2ray.aar
fi
ls -la V2rayNG/app/libs/

# hev-socks5-tunnel libs: needed (submodule). Use prebuilt from v2rayNG releases? No - build via NDK is heavy.
# Try fetching prebuilt from an official mirror of last release artifact - check what's in the apk instead later.
echo "=== CLONE DONE $(date) ==="
df -h / | tail -1
