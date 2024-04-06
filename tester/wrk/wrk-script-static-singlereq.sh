#!/bin/sh

wrk -c $NUM_CONNECTIONS \
    -t $NUM_THREAD \
    --timeout 1s \
    --latency \
    -d "${DEFAULT_DURATION}s" \
    $TARGET_URL/wrk/static-singlereq

