#!/bin/bash

 

. function.sh

TMP1=`SCRIPTNAME`.log

> $TMP1  

BAR

CODE [U-33]  DNS 보안 버전 패치 '확인 필요'

cat << EOF >> $result

[양호]: DNS 서비스를 사용하지 않거나 주기적으로 패치를 관리하고 있는 경우

[취약]: DNS 서비스를 사용하며 주기적으로 패치를 관리하고 있지 않는 경우


EOF

BAR


# Check if the DNS service is running
if systemctl is-active --quiet named.service; then
    WARN "DNS 서비스가 실행 중"
    # Get the version of bind
    version=$(named -v | awk '{print $3}' | sed 's/[^0-9.]*//g')
    INFO "설치된 바인드 버전: $version"
    # Check if the version is vulnerable
    if [[ "$version" == "8.4.6" || "$version" == "8.4.7" || "$version" == "9.2.8-P1" || "$version" == "9.3.4-P1" || "$version" == "9.4.1-P1" || "$version" == "9.5.0a6" ]]; then
        OK "DNS 서비스가 취약하지 않은 버전을 사용하고 있습니다."
    else
        WARN "DNS 서비스가 취약한 버전을 사용하고 있습니다. 취약하지 않은 버전으로 업데이트하는 것을 고려하십시오."
    fi
else
    OK "DNS 서비스가 실행되고 있지 않습니다."
fi



cat $result

echo ; echo