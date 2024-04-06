#!/bin/sh

source /web/tester/env.sh

pause_test() {
  echo "pausing for 60 seconds...";
  sleep 60;
}

echo "==============================="
echo "starting test using wrk..."
wrk -c $NUM_CONNECTIONS \
    -t $NUM_THREAD \
    --timeout 1s \
    --latency \
    -d "${DEFAULT_DURATION}s" \
    -s ./tester/wrk/script-dynamic-multireq.lua \
    $TARGET_URL/wrk/dynamic-multireq

pause_test

echo "==============================="
echo "starting test using wrk2..."
# set an impossibly high number as request rate
wrk2 -R 1M \
    -c $NUM_CONNECTIONS \
    -t $NUM_THREAD \
    --timeout 1s \
    --latency \
    -d "${DEFAULT_DURATION}s" \
    -s ./tester/wrk/script-dynamic-multireq.lua \
    $TARGET_URL/wrk2/dynamic-multireq


