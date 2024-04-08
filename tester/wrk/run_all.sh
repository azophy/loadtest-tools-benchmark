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
$SCRIPTPATH/wrk-script-static-singlereq.sh
$SCRIPTPATH/wrk-script-dynamic-singlereq.sh
$SCRIPTPATH/wrk-script-static-multireq.sh
$SCRIPTPATH/wrk-script-dynamic-multireq.sh
$SCRIPTPATH/wrk2-script-static-singlereq.sh
$SCRIPTPATH/wrk2-script-dynamic-singlereq.sh
$SCRIPTPATH/wrk2-script-static-multireq.sh
$SCRIPTPATH/wrk2-script-dynamic-multireq.sh
END

