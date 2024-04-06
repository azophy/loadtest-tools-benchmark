#!/bin/sh

source /web/tester/env.sh

pause_test() {
  echo "pausing for 60 seconds...";
  sleep 60;
}

echo "==============================="
echo "starting test using wrk..."
./tester/wrk/wrk-script-dynamic-multireq.sh

pause_test

echo "==============================="
echo "starting test using wrk2..."
./tester/wrk/wrk2-script-dynamic-multireq.sh

