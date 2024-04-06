#!/bin/sh

wrk2 -R 1M \
    -c $NUM_CONNECTIONS \
    -t $NUM_THREAD \
    --timeout 1s \
    --latency \
    -d "${DEFAULT_DURATION}s" \
    $TARGET_URL/wrk2/static-singlereq

