#!/bin/bash

run_name=$1
log_path="${2:-./log}"

# echo $log_path/$run_name.log

nohup python $run_name.py > $log_path/$run_name.log 2>&1 &
# pid1=$!

tail -f $log_path/$run_name.log
