#!/bin/bash

 

. function.sh


TMP1=`SCRIPTNAME`.log

> $TMP1   

BAR

CODE [U-27]  RPC 서비스 확인 

cat << EOF >> $result

[양호]: 불필요한 RPC 서비스가 비활성화 되어 있는 경우

[취약]: 불필요한 RPC 서비스가 활성화 되어 있는 경우


EOF

BAR

services=("sadmin" "rpc.*" "rquotad" "shell" "login" "exec" "talk" "time" "discard" "chargen" "printer" "uucp" "echo" "daytime" "dtscpt" "finger")

for service in "${services[@]}"
do
    if systemctl is-active --quiet "$service.service"; then
        WARN "$service 서비스 중지"
        systemctl stop "$service.서비스"
    else
        OK "$service 서비스가 실행되고 있지 않습니다."
    fi
done




 

cat $result

echo ; echo