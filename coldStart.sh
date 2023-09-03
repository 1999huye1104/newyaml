#!/bin/bash
read -p "请输入函数名称：" name
faas-cli function run-kuasar-wasm --name $fn --image ghcr.io/containerd/runwasi/wasi-demo-app:v0.0.1   --port  10086

invokeTime="$(date +%Y%m%d:%T).$((10#$(date +%N)/1000000))"

curl -X POST -H "Content-Type: application/json" -d '{"args":["White", "Hank"]}' http://43.135.161.20:32046/fission-function/$fn

endTime="$(date +%Y%m%d:%T).$((10#$(date +%N)/1000000))"

echo "invokeTime:$invokeTime,endTime:$endTime"