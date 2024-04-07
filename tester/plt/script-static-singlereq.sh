#!/bin/sh

$(go env GOPATH)/bin/plt --concurrency $PLT_CONCURRENCY \
                         --duration="${DEFAULT_DURATION}s" \
                         curl -X GET "$TARGET_URL/plt/static-singlereq"

