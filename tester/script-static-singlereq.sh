#!/bin/sh

source /web/tester/env.sh

pause_test() {
  echo "pausing for $SLEEP_DURATION seconds...";
  sleep $SLEEP_DURATION;
}

echo "==============================="
echo "starting test using vegeta..."
echo "GET $TARGET_URL/vegeta" | vegeta attack -rate 0 -max-workers $NUM_CONNECTIONS -duration "${DEFAULT_DURATION}s"  | vegeta report -type=text

pause_test

echo "==============================="
echo "starting test using plt..."
PLT_CONCURRENCY_MULTIPLIER=5 # arbitrary number based on experiments to achieve max throughput
PLT_CONCURRENCY=$(($NUM_THREAD * $PLT_CONCURRENCY_MULTIPLIER))
$(go env GOPATH)/bin/plt --concurrency $PLT_CONCURRENCY \
                         --duration="${DEFAULT_DURATION}s" \
                         curl -X GET "$TARGET_URL/plt"

pause_test

echo "==============================="
echo "starting test using k6..."
k6 run tester/k6/script.js

pause_test

echo "==============================="
echo "starting test using autocannon..."
# we dont specify num of workers as IME it actually reduce the load
node tester/autocannon/script-static-singlereq.js

pause_test

echo "==============================="
echo "starting test using wrk..."
wrk -c $NUM_CONNECTIONS -t $NUM_THREAD --timeout 1s --latency -d "${DEFAULT_DURATION}s" $TARGET_URL/wrk

pause_test

echo "==============================="
echo "starting test using cassowary..."
cassowary run -u $TARGET_URL/cassowary -c 50 -d "${DEFAULT_DURATION}"

pause_test

echo "==============================="
echo "starting test using drill..."
drill --benchmark tester/drill/script.yaml

pause_test

#echo "==============================="
#echo "starting test using artilerry..."
#artillery run tester/artillery/script.yaml

#pause_test
