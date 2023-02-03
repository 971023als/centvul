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

 


cat $result

echo ; echo
