#!/bin/sh

TARGET_URL=http://target:3000/test
DEFAULT_DURATION="60"

pause_test() {
  echo "pausing for 60 seconds...";
  sleep 60;
}

echo "starting test using wrk..."
wrk --latency -d "${DEFAULT_DURATION}s" -s ./tester/wrk/script-dynamic-singlereq.lua $TARGET_URL/wrk

pause_test

echo "starting test using autocannon..."
# we dont specify num of workers as IME it actually reduce the load
autocannon --latency -c 1000 -d "${DEFAULT_DURATION}s"  $TARGET_URL/autocannon

pause_test

echo "starting test using vegeta..."
echo "GET $TARGET_URL/vegeta" | vegeta attack -rate=30000/s -duration "${DEFAULT_DURATION}s"  | vegeta report -type=text

pause_test

echo "starting test using plt..."
$(go env GOPATH)/bin/plt --concurrency 50 --duration="${DEFAULT_DURATION}s"  curl -X GET "$TARGET_URL/plt"

pause_test

echo "starting test using k6..."
k6 run tester/k6/script.js

pause_test

echo "starting test using cassowary..."
cassowary run -u $TARGET_URL/cassowary -c 50 -d "${DEFAULT_DURATION}"

pause_test

echo "starting test using drill..."
drill --benchmark tester/drill/script.yaml

pause_test

#echo "starting test using artilerry..."
#artillery run tester/artillery/script.yaml

#pause_test

pause_test
