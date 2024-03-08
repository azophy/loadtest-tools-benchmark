#!/bin/sh

export TARGET_URL=http://target:3000/test
export DEFAULT_DURATION="60"

pause_test() {
  echo "pausing for 60 seconds...";
  sleep 60;
}

echo "===============================\nstarting test using vegeta..."
echo "GET $TARGET_URL/vegeta" | vegeta attack -rate 0 -max-workers 10000 -duration "${DEFAULT_DURATION}s"  | vegeta report -type=text

pause_test

echo "===============================\nstarting test using plt..."
$(go env GOPATH)/bin/plt --concurrency 1000 --duration="${DEFAULT_DURATION}s"  curl -X GET "$TARGET_URL/plt"

pause_test

echo "===============================\nstarting test using k6..."
k6 run tester/k6/script.js

pause_test

echo "===============================\nstarting test using cassowary..."
cassowary run -u $TARGET_URL/cassowary -c 50 -d "${DEFAULT_DURATION}"

pause_test

echo "===============================\nstarting test using drill..."
drill --benchmark tester/drill/script.yaml

pause_test

#echo "===============================\nstarting test using artilerry..."
#artillery run tester/artillery/script.yaml

#pause_test

echo "===============================\nstarting test using autocannon..."
# we dont specify num of workers as IME it actually reduce the load
node tester/autocannon/script-static-singlereq.js

pause_test

echo "===============================\nstarting test using wrk..."
wrk -c 1000 -t 8 --timeout 1s --latency -d "${DEFAULT_DURATION}s" $TARGET_URL/wrk

pause_test

