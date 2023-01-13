#!/bin/bash

 

. function.sh

TMP1=`SCRIPTNAME`.log

> $TMP1   

 

BAR

CODE [U-34] DNS Zone Transfer 설정

cat << EOF >> $result

[양호]: DNS 서비스 미사용 또는, Zone Transfer를 허가된 사용자에게만 허용한 경우

[취약]: DNS 서비스를 사용하여 Zone Transfer를 모든 사용자에게 허용한 경우

EOF

BAR


# Check if named.conf file exists
if [ -f /etc/named.conf ]; then
    WARN "name.conf 파일 발견"
    # Check if the allow-transfer option is set in the primary zone
    primary_zone=$(grep -i 'type master' /etc/named.conf | awk '{print $2}')
    if grep -q "allow-transfer" "$primary_zone"; then
        WARN "allow-transfer 옵션이 기본 영역에서 설정됨"
        # Check if the allow-transfer option is set to a specific IP address or IP range
        transfer_ip=$(grep -i 'allow-transfer' "$primary_zone" | awk '{print $2}')
        if [[ $transfer_ip =~ ^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\/[0-9]{1,2}$ ]]; then
            OK "allow-transfer가 특정 IP 주소 또는 IP 범위로 설정됨: $transfer_ip"
        else
            WARN "allow-transfer가 특정 IP 주소 또는 IP 범위로 설정되지 않았습니다. 영역 전송이 안전하지 않습니다"
        fi
    else
        WARN "allow-transfer 옵션이 기본 영역에서 설정되지 않았습니다. 영역 전송이 안전하지 않습니다"
    fi
    # Check if the secondary zone has the allow-transfer option
    secondary_zone=$(grep -i 'type slave' /etc/named.conf | awk '{print $2}')
    if grep -q "allow-transfer" "$secondary_zone"; then
        WARN "allow-transfer 옵션이 보조 영역에 설정되어 있으며, 영역 전송이 안전하지 않습니다"
    else
        WARN "allow-transfer 옵션이 보조 영역에서 설정되지 않았습니다. 영역 전송이 허용되지 않습니다."
    fi
else
    OK "name.conf 파일을 찾을 수 없습니다"
fi




cat $result

echo ; echo