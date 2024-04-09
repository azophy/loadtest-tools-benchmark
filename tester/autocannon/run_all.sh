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
node $SCRIPTPATH/script-dynamic-singlereq-setupreq-withworker.js
node $SCRIPTPATH/script-dynamic-singlereq-setupreq.js
END

