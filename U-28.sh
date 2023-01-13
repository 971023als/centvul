#!/bin/bash

 

. function.sh

 
TMP1=`SCRIPTNAME`.log

> $TMP1
 

BAR

CODE [U-28] NIS, NIS+ 점검 

cat << EOF >> $result

[양호]: NIS 서비스가 비활성화 되어 있거나. 필요 시 NIS+를 사용하는 경우

[취약]: NIS 서비스가 활성화 되어 있는 경우

EOF

BAR


if systemctl is-active --quiet nis.service; then
    WARN "nis 서비스가 실행 중입니다"
    if grep -q "NISPLUS" /etc/yp.conf; then
        OK "더 강력한 데이터 인증을 가진 NIS+ 사용"
    else
        WARN "NIS 사용, 더 강력한 데이터 인증으로 NIS+ 사용 고려"
    fi
else
    OK "nis 서비스가 실행되고 있지 않습니다"
fi




cat $result

echo ; echo
 



 
