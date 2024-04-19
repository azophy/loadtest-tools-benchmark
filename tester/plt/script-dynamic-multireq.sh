#!/bin/sh

source /web/tester/env.sh

cd $SCRIPTPATH

go run custom_plt.go \
  --concurrency $PLT_CONCURRENCY \
  --duration="${DEFAULT_DURATION}s" \
  --dynamic \
  --multireq \
  curl "$TARGET_URL/plt/dynamic-multireq"

