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
bun $SCRIPTPATH/script-static-singlereq-old.js
bun $SCRIPTPATH/script-static-singlereq.js
bun $SCRIPTPATH/script-dynamic-singlereq.js
bun $SCRIPTPATH/script-static-multireq.js
bun $SCRIPTPATH/script-dynamic-multireq.js
END

