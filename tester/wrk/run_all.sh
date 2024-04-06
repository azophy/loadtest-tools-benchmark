#!/bin/sh

source /web/tester/env.sh

pause_test() {
  echo "pausing for 60 seconds...";
  sleep 60;
}

# busybox's ash array loop style. ref: https://unix.stackexchange.com/a/384643
while IFS= read -r service
do
    echo "==============================="
    echo $service
    $service

    pause_test
done << END
./tester/wrk/wrk-script-static-singlereq.sh
./tester/wrk/wrk-script-dynamic-singlereq.sh
./tester/wrk/wrk-script-static-multireq.sh
./tester/wrk/wrk-script-dynamic-multireq.sh
./tester/wrk/wrk2-script-static-singlereq.sh
./tester/wrk/wrk2-script-dynamic-singlereq.sh
./tester/wrk/wrk2-script-static-multireq.sh
./tester/wrk/wrk2-script-dynamic-multireq.sh
END


