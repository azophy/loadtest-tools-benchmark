#!/bin/sh

$(go env GOPATH)/bin/go-wrk -c $NUM_CONNECTIONS \
                            -T 1000 \
                            -d $DEFAULT_DURATION \
                            $TARGET_URL/gowrk/static-singlereq

