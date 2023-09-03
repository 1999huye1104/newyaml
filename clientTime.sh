#!/bin/bash
read -p "请输入循环次数：" n
read -p "请输入函数名称：" name
total_duration=0  # 总执行时间
for (( i=1; i<=n; i++ ))
do
    fn="${name}${i}"

    faas-cli function run-kuasar-wasm --name $fn --image ghcr.io/containerd/runwasi/wasi-demo-app:v0.0.1   --port  10086

    start=$(date +%s%N)
    curl -X POST -H "Content-Type: application/json" -d '{"args":["White", "Hank"]}' http://43.135.161.20:32046/fission-function/$fn
    end=$(date +%s%N)

    duration=$((($end - $start)/1000000))
    total_duration=$(($total_duration + $duration))
    echo "第 $i 次操作执行时间：$duration 毫秒"

    faas-cli function delete --name $fn
done
# 计算平均执行时间（毫秒）
average_duration=$(($total_duration / $n))
echo "用户冷启动函数获取结果平均操作执行时间：$average_duration 毫秒"