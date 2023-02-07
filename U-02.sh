#!/bin/bash 

 

. function.sh

 

TMP1=$(SCRIPTNAME).log

> $TMP1

 
BAR

CODE [U-02] 패스워드 복잡성 설정

cat << EOF >> $result

[양호]: 영문 숫자 특수문자가 혼합된 8 글자 이상의 패스워드가 설정된 경우.

[취약]: 영문 숫자 특수문자 혼합되지 않은 8 글자 미만의 패스워드가 설정된 경우.

EOF

BAR
# /etc/login.defs에서 최소 암호 길이 확인
min_len_defs=$(grep "^PASS_MIN_LEN" /etc/login.defs | awk '{print $2}')
if [ "$min_len_defs" -eq "$min_len_defs" ] 2>/dev/null; then
  if [ "$(expr "$min_len_defs" + 0)" -ge 8 ]; then
    OK "/etc/login.defs의 최소 암호 길이가 $min_len_defs 로 설정됨"
  else
    WARN "/etc/login.defs의 최소 암호 길이가 8보다 작음"
fi

auth_file="/etc/pam.d/common-auth"
auth_config="password requisite pam_cracklib.so retry=3 minlen=8 lcredit=-1 ucredit=-1 dcredit=-1 ocredit=-1"

if grep -q "$auth_config" "$auth_file"; then
  OK "구성이 설정되었습니다"
else
  INFO "구성 설정 중..."
  echo "$auth_config" | sudo tee -a "$auth_file"
  INFO "구성 설정"
fi


cat $result

echo ; echo
