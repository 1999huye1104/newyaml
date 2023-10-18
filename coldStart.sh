#!/bin/bash
read -p "请输入函数名称：" nam
faas-cli function run-kuasar-wasm --name $nam --image ghcr.io/containerd/runwasi/wasi-demo-app:v0.0.1   --port  10086

invokeTime="$(date +%Y%m%d:%T).$((10#$(date +%N)/1000000))"

curl -X POST -H "Content-Type: application/json" -d '{"args":["White", "Hank"]}' http://43.153.27.229:32046/fission-function/$nam

endTime="$(date +%Y%m%d:%T).$((10#$(date +%N)/1000000))"

echo "invokeTime:$invokeTime,endTime:$endTime"

faas-cli function run-kuasar-wasm --name hey --image ghcr.io/containerd/runwasi/wasi-demo-app:v0.0.1   --port  10086