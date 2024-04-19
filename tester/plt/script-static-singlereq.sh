#!/bin/sh

source /web/tester/env.sh

cd $SCRIPTPATH

go run custom_plt.go \
  --concurrency $PLT_CONCURRENCY \
  --duration="${DEFAULT_DURATION}s" \
  curl "$TARGET_URL/plt/static-singlereq"

