#!/bin/bash

 

. function.sh

TMP1=`SCRIPTNAME`.log

> $TMP1

 

BAR

CODE [U-22] cron 파일 소유자 및 권한 설정

cat << EOF >> $TMP1

[양호]: cron 접근제어 파일 소유자가 root이고, 권한이 640 이하인 경우

[취약]: cron 접근제어 파일 소유자가 root가 아니거나, 권한이 640 이하가 아닌 경우

EOF

BAR

 

 

# cat filepem.list

# /etc/cron.allow root 640 rw-r-----

# /etc/cron.deny root 640 rw-r-----

 

 

CHECK_FILE=/usr/bin/crontab

CHOWN=$(ls -l /usr/bin/crontab | awk '{print $3}')

CHECK_PERM=$(find /usr/bin/crontab -type f -perm -644 -ls | grep -v rw-r--r-- | awk '{print $3}')

CHECK_PERM2=$(ls -l /usr/bin/crontab | awk '{print $1}')

 

if [ -f $CHECK_FILE ] ; then

INFO "$CHECK_FILE 파일이 존재하며 소유자와 권한을 체크합니다."

if [ $CHOWN = 'root' ] ; then

OK "파일의 소유자가 root 입니다."

if [ $CHECK_PERM2 > 640 ] ; then

WARN "파일의 권한이 640 이상으로 되어 있습니다."

echo

echo "$CHECK_FILE 의 권한이 $CHECK_PERM2 으로 되어 있습니다." > $TMP1

INFO "권한 설정 상태는 $TMP1 파일에서 확인하세요."

else

OK "파일의 권한이 640 이하로 되어 있습니다."

fi

else

WARN "파일의 소유자가 root가 아닙니다."

fi

else

INFO "$CHECK_FILE 이 존재하지 않습니다."

fi

cat $TMP1

echo ; echo
