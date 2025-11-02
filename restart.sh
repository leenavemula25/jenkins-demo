#!/bin/bash
pkill -f "node server.js" || true
nohup node server.js > output.log 2>&1 &
