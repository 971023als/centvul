#!/bin/bash

 

. function.sh

 
TMP1=`SCRIPTNAME`.log

> $TMP1
 

BAR

CODE [U-29] tftp, talk 서비스 비활성화

cat << EOF >> $result

[양호]: tftp, talk, ntalk 서비스가 비활성화 되어 있는 경우

[취약]: tftp, talk, ntalk 서비스가 활성화 되어 있는 경우

EOF

BAR

 
services=( "tftp" "talk" "ntalk" )

for service in "${services[@]}"
do
    if systemctl is-active --quiet "$service"; then
        WARN "$service 가 실행 중입니다"
    else
        OK "$service 가 실행 중이 아닙니다"
    fi
done

cat $result

echo ; echo
 
