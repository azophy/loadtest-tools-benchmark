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
    -s ./tester/wrk/script-static-multireq.lua \
    $TARGET_URL/wrk/static-multireq

