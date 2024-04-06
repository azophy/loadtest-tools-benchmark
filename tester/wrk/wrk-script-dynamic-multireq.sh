#!/bin/sh

wrk -c $NUM_CONNECTIONS \
    -t $NUM_THREAD \
    --timeout 1s \
    --latency \
    -d "${DEFAULT_DURATION}s" \
    -s ./tester/wrk/script-dynamic-multireq.lua \
    $TARGET_URL/wrk/dynamic-multireq
