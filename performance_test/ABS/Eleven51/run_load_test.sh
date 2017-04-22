#!/usr/bin/env bash
echo "Open browser and go to http://127.0.0.1:8089"
locust --host=http://api.kaiworship.xyz 2>/dev/null