#!/bin/sh

source /web/tester/env.sh

echo "GET $TARGET_URL/vegeta/static-singlereq-old" | vegeta attack -rate 0 -max-workers $NUM_CONNECTIONS -duration "${DEFAULT_DURATION}s"  | vegeta report -type=text

