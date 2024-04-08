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
$SCRIPTPATH/vegeta/script-static-multireq.sh
$SCRIPTPATH/plt/script-static-multireq.sh
END

