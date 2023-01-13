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


DS=`dig +short @168.126.63.1 porttest.dns-oarc.net TXT | awk -Fis '{print $2}' | awk -F: {'print $1'} | sed '1d' | awk '{print $1}'`

if [ $DS=GOOD -o GREAT ]
	then
		OK "    ==> [안전] DNS 보안 패치가 최신 버전입니다" 
	else
		WARN "    ==> [취약] DNS 보안 패치가 구 버전입니다" 
fi



cat $result

echo ; echo