#!/bin/sh

pause_test() {
  echo "pausing for 60 seconds...";
  sleep 60;
}

export TARGET_URL=http://target:3000/test
export DEFAULT_DURATION="60"
export NUM_THREAD=8
export NUM_CONNECTIONS=1000
export SLEEP_DURATION=60
export NODE_PATH=$(npm root -g)

export PLT_CONCURRENCY_MULTIPLIER=5 # arbitrary number based on experiments to achieve max throughput
export PLT_CONCURRENCY=$(($NUM_THREAD * $PLT_CONCURRENCY_MULTIPLIER))

# get this script's path. ref: https://stackoverflow.com/a/11114547/2496217
export SCRIPT=$(realpath "$0")
export SCRIPTPATH=$(dirname "$SCRIPT")

