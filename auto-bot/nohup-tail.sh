#!/bin/bash

run_name=$1
log_path=$2 || "./log"

nohup python $run_name.py > $log_path/$run_name.log 2>&1 &
tail -f -pid=PID $log_path/$run_name.log 