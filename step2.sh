#!/usr/bin/env bash
ip=`ifconfig -a|grep inet|grep -v 127.0.0.1|grep -v inet6|awk '{print $2}'|tr -d "addr:"`
mkdir -p keys
cntFile=".showcnt.txt"
if [ ! -f $cntFile ]; then
echo "未运行step1！"
exit
fi

tCnt=`cat $cntFile`

for ((i=1; i<=tCnt; i ++))
do
cp /var/lib/node${tCnt}/keys/swarm.key node${tCnt} /keys/${ip}-${tCnt}.key
screen -dmS bee$i
cmd=$"bee start  --config node${i}.yaml";
screen -x -S bee$i -p 0 -X stuff "$cmd"
screen -x -S bee$i -p 0 -X stuff $'\n'
done
sz /keys/*
