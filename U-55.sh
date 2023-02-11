#!/bin/bash

 

. function.sh

 
TMP1=`SCRIPTNAME`.log

> $TMP1
 

BAR

CODE [U-55] hosts.lpd 파일 소유자 및 권한 설정

cat << EOF >> $result

[양호]: 파일의 소유자가 root이고 권한이 600인 경우

[취약]: 파일의 소유자가 root가 아니고 권한이 600이 아닌 경우

EOF

BAR

# Check if the file exists
if [ ! -f /etc/hosts.lpd ]; then
  INFO "hosts.lpd 파일이 없습니다. 확인해주세요."
fi

hosts=$(stat -c '%U' /etc/hosts.lpd)
dec_perms=$(printf "%d" $hosts)

if [ $dec_perms = "root" ]; then
  WARN "Owner of hosts.lpd의 소유자는 루트입니다. 이것은 허용되지 않습니다."
fi

# Check permission on the file
host=$(stat -c '%a' /etc/hosts.lpd)
dec_perm=$(printf "%d" $host)

if [ $dec_perm = "600" ]; then
  WARN  "hosts.lpd에 대한 권한이 600으로 설정되었습니다. 이것은 허용되지 않습니다."
fi


cat $result

echo ; echo
