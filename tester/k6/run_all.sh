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
k6 run $SCRIPTPATH/script-static-singlereq.js
k6 run $SCRIPTPATH/script-dynamic-singlereq.js
k6 run $SCRIPTPATH/script-static-multireq.js
k6 run $SCRIPTPATH/script-dynamic-multireq.js
END

