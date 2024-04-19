#!/bin/sh

source /web/tester/env.sh

cd $SCRIPTPATH

# busybox's ash array loop style. ref: https://unix.stackexchange.com/a/384643
while IFS= read -r service
do
    echo "==============================="
    echo "$service"
    $service

    pause_test
done << END
$SCRIPTPATH/script-static-singlereq-old.sh
$SCRIPTPATH/script-static-singlereq.sh
$SCRIPTPATH/script-dynamic-singlereq.sh
$SCRIPTPATH/script-static-multireq.sh
$SCRIPTPATH/script-dynamic-multireq.sh
END

