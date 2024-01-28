#!/bin/bash

# 用法：$0 进程名。杀死这个名字的进程

process_name=$1

if [ -z "$1" ]
then
    echo "请输入进程名字zzz"
    exit 1
fi

# 查看匹配进程
ps aux | grep $process_name

# 使用pgrep获取进程号
# -fn，-n获取最新进程号
# -fo，-o获取最旧进程号
pids=$(pgrep -f $process_name)

# 遍历进程号并杀死进程
for pid in $pids
do
    echo "Killing process $pid"
    kill -9 $pid
done