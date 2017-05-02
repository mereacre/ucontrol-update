#!/bin/bash

MONITOR_SEARCH="$(ps aux | grep nodejs | wc -l)"
if [ $MONITOR_SEARCH -eq 5 ]; then
  echo "Found ${MONITOR_SEARCH} monitor processes"
  echo "Killing all monitoring processe..."
  sudo pkill -f nodejs
fi
