#!/bin/bash

 

. function.sh

 

TMP1=`SCRIPTNAME`.log

> $TMP1

TMP2=/tmp/tmp2

> $TMP2

 

BAR

CODE [U-21] r 계열 서비스 비활성화

cat << EOF >> $result

[양호]: r 계열 서비스가 비활성화 되어 있는 경우

[취약]: r 계열 서비스가 활성화 되어 있는 경우

EOF

BAR


if test -f /etc/xinetd.d/rlogin
	then
		if [ "`cat /etc/xinetd.d/rlogin | grep disable | awk '{print $3}'`" = yes ]
			then
				OK " [안전] rlogin 서비스가 설치되어 있으나 비활성화 되어 있습니다" 
			else
				WARN " [취약] rlogin 서비스가 설치되어 있고, 활성화 되어 있습니다" 
		fi
	else
		OK " [안전] rlogin 서비스가 설치되어 있지 않습니다" 
fi


  

cat $result

echo ; echo