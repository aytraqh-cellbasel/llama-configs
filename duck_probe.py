#!/usr/bin/env python3
import json, urllib.request, time, uuid, sys, ssl
sol = open("/tmp/ds.txt").read().strip()
q = sys.argv[1] if len(sys.argv) > 1 else "say ok"
signals = json.dumps({"start": int(time.time()*1000), "events": [], "end": 8000}, separators=(",",":"))
sig = __import__("base64").b64encode(signals.encode()).decode()
body = {"model":"gpt-6-luna","messages":[{"role":"user","content":[{"type":"text","text":q}]}],
        "canUseTools":True,"reasoningEffort":"none","canUseApproxLocation":None,
        "canDelegateImageGeneration":None,"canShowGreeting":False}
req = urllib.request.Request(
    "https://duckduckgo.com/duckchat/v1/chat",
    data=json.dumps(body, separators=(",",":")).encode(),
    headers={
        "Content-Type": "application/json",
        "accept": "text/event-stream",
        "x-duckai-continuation": "resubmit-context",
        "x-duckai-consent-purposes": "user-location,image-generation,web-search",
        "x-duckai-tool-approval": "web-search",
        "x-duckai-response-id": str(uuid.uuid4()),
        "x-fe-version": "serp_20261030_144212_ET-0bd1d996ce553d0634b52a621e35875363f1b5e8",
        "x-fe-signals": sig,
        "X-Vqd-Hash-1": sol,
        "x-ddg-journey-id": uuid.uuid4().hex,
        "User-Agent": "Mozilla/5.0 (Linux; Android 14; Pixel 8) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Mobile Safari/537.36",
        "Origin": "https://duck.ai",
        "Referer": "https://duck.ai/",
    })
ctx = ssl.create_default_context()
resp = urllib.request.urlopen(req, timeout=60, context=ctx)
data = resp.read().decode(errors="replace")
print("STATUS:", resp.status)
print(data[:600])
