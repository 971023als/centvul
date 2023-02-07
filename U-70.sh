#!/bin/bash

 

. function.sh

 
TMP1=`SCRIPTNAME`.log

> $TMP1   
 

BAR

CODE [U-70] expn, vrfy 명령어 제한

cat << EOF >> $result

[양호]: SMTP 서비스 미사용 또는, noexpn, novrfy 옵션이 설정되어 있는 경우

[취약]: SMTP 서비스 사용하고, noexpn, novrfy 옵션이 설정되어 있지 않는 경우

EOF

BAR


# Read the /etc/mail/sendmail.cf file
while read line; do
  # Check if the line starts with "O PrivacyOptions="
  if [[ $line == O\ PrivacyOptions=* ]]; then
    options=${line#O PrivacyOptions=}

    # Check if the options contain "noexpn", "novrfy", and "goaway"
    if [[ $options == *noexpn* ]] && [[ $options == *novrfy* ]] && [[ $options == *goaway* ]]; then
      echo "PrivacyOptions are set correctly: noexpn, novrfy, and goaway"
    else
      echo "PrivacyOptions are not set correctly. Required options: noexpn, novrfy, and goaway"
    fi

    # We found the line, no need to continue reading the file
    break
  fi
done < /etc/mail/sendmail.cf

    

cat $result

echo ; echo 
