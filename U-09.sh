#!/bin/bash

 

. function.sh

 

TMP1=`SCRIPTNAME`.log

>$TMP1

 

 

BAR

CODE [U-09] /etc/hosts 파일 소유자 및 권한 설정.

cat << EOF >> $result

[양호]: /etc/hosts 파일의 소유자가 root이고, 권한이 600인 경우

[취약]: /etc/hosts 파일의 소유자가 root가 아니거나, 권한이 600이 아닌 경우

EOF

BAR

 

 



CHECK_FILE=/etc/hosts

CHOWN=$(ls -l /etc/hosts | awk '{print $3}')

CHECK_PERM=$(find /etc/hosts -type f -perm -600 -ls | grep -v rw-r--r-- | awk '{print $3}')

CHECK_PERM2=$(ls -l /etc/hosts | awk '{print $1}')

 

if [ -f $CHECK_FILE ] ; then

INFO "$CHECK_FILE 파일이 존재하며 소유자와 권한을 체크합니다."

if [ $CHOWN = 'root' ] ; then

OK "파일의 소유자가 root 입니다."

if [ $CHECK_PERM2 > 600 ] ; then

WARN "파일의 권한이 600 이상으로 되어 있습니다."

echo

echo "$CHECK_FILE 의 권한이 $CHECK_PERM2 으로 되어 있습니다." > $TMP1

INFO "권한 설정 상태는 $TMP1 파일에서 확인하세요."

else

OK "파일의 권한이 600 이하로 되어 있습니다."

fi

else

WARN "파일의 소유자가 root가 아닙니다."

fi

else

INFO "$CHECK_FILE 이 존재하지 않습니다."

fi

cat $result

echo ; echo
