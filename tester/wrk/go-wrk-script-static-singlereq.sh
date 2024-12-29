#!/bin/sh

go-wrk -c $NUM_CONNECTIONS \
       -T 1s \
       -d "${DEFAULT_DURATION}s" \
       $TARGET_URL/gowrk/static-singlereq

