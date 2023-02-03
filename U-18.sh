#!/bin/bash

 

. function.sh


TMP1=`SCRIPTNAME`.log

>$TMP1    

BAR

CODE [U-18] 접속 IP 및 포트 제한 

cat << EOF >> $result

[양호]: /etc/hosts.deny 파일에 ALL Deny 설정후

/etc/hosts.allow 파일에 접근을 허용할 특정 호스트를 등록한 경우

[취약]: 위와 같이 설정되지 않은 경우

EOF

BAR

 
INFO "iptables 규칙 표시:"
iptables -S

INFO "특정 규칙에 대한 입력 체인 확인"
iptables -C INPUT -p tcp --dport 22 -j ACCEPT
if [ $? -eq 0 ]; then
    OK "수신 SSH 트래픽(포트 22)을 허용하는 규칙이 INPUT 체인에 있습니다"
  else
    WARN "수신 SSH 트래픽(포트 22)을 허용하는 규칙이 INPUT 체인에 없습니다"
  fi

INFO "특정 규칙에 대한 출력 체인 확인"
iptables -C OUTPUT -p tcp --dport 80 -j ACCEPT

if [ $? -eq 0 ]; then
    OK "출력 체인에 발신 HTTP 트래픽(포트 80)을 허용하는 규칙이 있습니다"
  else
    WARN "출력 체인에 발신 HTTP 트래픽(포트 80)을 허용하는 규칙이 없습니다"
  fi
fi

 

cat $result

echo ; echo
