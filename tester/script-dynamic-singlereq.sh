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
$SCRIPTPATH/wrk/wrk-script-dynamic-singlereq.sh
$SCRIPTPATH/wrk/wrk2-script-dynamic-singlereq.sh
k6 run $SCRIPTPATH/k6/script-dynamic-singlereq.js
node $SCRIPTPATH/autocannon/script-dynamic-singlereq.js
cd $SCRIPTPATH/vegeta && go run base.go script-dynamic-singlereq.go
END

