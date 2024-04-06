#!/bin/sh

source /web/tester/env.sh

pause_test() {
  echo "pausing for $SLEEP_DURATION seconds...";
  sleep $SLEEP_DURATION;
}

echo "==============================="
echo "starting test using wrk..."
./tester/wrk/wrk-script-static-singlereq.sh

pause_test

echo "==============================="
echo "starting test using wrk2..."
./tester/wrk/wrk2-script-static-singlereq.sh

pause_test

echo "==============================="
echo "starting test using vegeta..."
echo "GET $TARGET_URL/vegeta/static-singlereq" | vegeta attack -rate 0 -max-workers $NUM_CONNECTIONS -duration "${DEFAULT_DURATION}s"  | vegeta report -type=text

pause_test

echo "==============================="
echo "starting test using plt..."
PLT_CONCURRENCY_MULTIPLIER=5 # arbitrary number based on experiments to achieve max throughput
PLT_CONCURRENCY=$(($NUM_THREAD * $PLT_CONCURRENCY_MULTIPLIER))
$(go env GOPATH)/bin/plt --concurrency $PLT_CONCURRENCY \
                         --duration="${DEFAULT_DURATION}s" \
                         curl -X GET "$TARGET_URL/plt/static-singlereq"

pause_test

echo "==============================="
echo "starting test using k6..."
k6 run tester/k6/script-static-singlereq.js

pause_test

echo "==============================="
echo "starting test using autocannon..."
# we dont specify num of workers as IME it actually reduce the load
node tester/autocannon/script-static-singlereq.js

pause_test

echo "==============================="
echo "starting test using cassowary..."
cassowary run -u $TARGET_URL/cassowary/static-singlereq -c 50 -d "${DEFAULT_DURATION}"

pause_test

echo "==============================="
echo "starting test using drill..."
drill --benchmark tester/drill/script.yaml

pause_test

#echo "==============================="
#echo "starting test using artilerry..."
#artillery run tester/artillery/script.yaml

#pause_test
