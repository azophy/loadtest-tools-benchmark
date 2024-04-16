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
$SCRIPTPATH/script-static-singlereq.sh
go run $SCRIPTPATH/base.go $SCRIPTPATH/script-static-singlereq.go
go run $SCRIPTPATH/base.go $SCRIPTPATH/script-dynamic-singlereq.go
go run $SCRIPTPATH/base.go $SCRIPTPATH/script-static-multireq.go
go run $SCRIPTPATH/base.go $SCRIPTPATH/script-dynamic-multireq.go
END

