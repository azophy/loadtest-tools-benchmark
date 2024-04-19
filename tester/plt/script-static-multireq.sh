#!/bin/sh

source /web/tester/env.sh

cd $SCRIPTPATH

go run custom_plt.go \
  --concurrency $PLT_CONCURRENCY \
  --duration="${DEFAULT_DURATION}s" \
  --multireq \
  curl "$TARGET_URL/plt/static-multireq"

