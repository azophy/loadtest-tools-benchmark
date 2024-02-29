#!/bin/sh

TARGET_URL=http://target:3000/test
DEFAULT_DURATION="60s"

pause_test() { sleep 60; }

wrk --latency -d $DEFAULT_DURATION $TARGET_URL/wrk

pause_test

artillery run tester/artillery/script.yaml

pause_test

# we dont specify num of workers as IME it actually reduce the load
autocannon --latency -c 1000 -d $DEFAULT_DURATION $TARGET_URL/autocannon

pause_test

echo "GET $TARGET_URL/vegeta" | vegeta attack -rate=30000/s -duration $DEFAULT_DURATION | vegeta report -type=text

pause_test

$(go env GOPATH)/bin/plt --concurrency 50 --duration=$DEFAULT_DURATION curl -X GET "$TARGET_URL/plt"

pause_test

cassowary run -u $TARGET_URL/cassowary -c 50 -d $DEFAULT_DURATION

pause_test

drill --benchmark tester/drill/script.yaml

pause_test

k6 run tester/k6/script.js

pause_test

pause_test
