#!/bin/bash

 

. function.sh

 
TMP1=`SCRIPTNAME`.log

> $TMP1  
 

BAR

CODE [U-26] automountd 제거 '확인 필요'

cat << EOF >> $result

[양호]: automountd 서비스가 비활성화 되어있는 경우

[취약]: automountd 서비스가 활성화 되어있는 경우

EOF

BAR

 

AM=`ps -ef | grep 'automount\|autofs' | sed '$d'`

if [ "$AM" ]; then
		WARN "   ==> [취약] NFS 서비스가 동작 중입니다." 

else
	OK "   ==> [안전] NFS 서비스가 동작 중이지 않습니다." 
fi


 

cat $result

echo ; echo