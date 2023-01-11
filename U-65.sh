#!/bin/bash

 

. function.sh

 

 

BAR

CODE [U-65] at 파일 소유자 및 권한 설정

cat << EOF >> $U65

[양호]: at 접근제어 파일의 소유자가 root이고, 권한이 640 이하인 경우

[취약]: at 접근제어 파일의 소유자가 root가 아니거나, 권한이 640 이하가 아닌 경우

EOF

BAR



# Check if the at command is available
if command -v at >/dev/null; then
    echo "at 명령을 사용할 수 있습니다."
else
    echo "at 명령을 사용할 수 없습니다."
fi

# Check the permission of the at related file
at_dir="/etc/at.allow"
if [ -f $at_dir ]; then
    permission=$(stat -c %a $at_dir)
    if [ $permission -ge 640 ]; then
        echo "관련 파일의 권한이 640 이상입니다."
    else
        echo "관련 파일의 권한이 640 미만입니다."
    fi
else
    echo "관련 파일이 존재하지 않습니다"
fi

cat $U65

echo ; echo 