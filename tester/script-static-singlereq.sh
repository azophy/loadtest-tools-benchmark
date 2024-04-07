#!/bin/sh

source /web/tester/env.sh

# busybox's ash array loop style. ref: https://unix.stackexchange.com/a/384643
while IFS= read -r service
do
    echo "==============================="
    echo "$service"
    $service

    pause_test
done << END
$SCRIPTPATH/vegeta/script-static-singlereq.sh
$SCRIPTPATH/plt/script-static-singlereq.sh
k6 run $SCRIPTPATH/k6/script-static-singlereq.js
node $SCRIPTPATH/autocannon/script-static-singlereq.js
$SCRIPTPATH/wrk/wrk-script-static-singlereq.sh
$SCRIPTPATH/wrk/wrk2-script-static-singlereq.sh
$SCRIPTPATH/cassowary/script-static-singlereq.sh
drill --benchmark $SCRIPTPATH/drill/script.yaml
END

#not used commands
#artillery run $SCRIPTPATH/artillery/script.yaml

