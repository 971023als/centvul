#!/bin/bash

 

. function.sh

 
TMP1=`SCRIPTNAME`.log

> $TMP1 
 

BAR

CODE [U-71] Apache 웹서비스 정보 숨김

cat << EOF >> $result

[양호]: ServerTokens Prod, ServerSignature Off로 설정되어있는 경우

[취약]: ServerTokens Prod, ServerSignature Off로 설정되어있지 않은 경우

EOF

BAR

# Define the Apache configuration file path
CONF_FILE="/etc/httpd/conf/httpd.conf"

# Check if ServerTokens is set to Prod
if grep -q "ServerTokens Prod" $CONF_FILE; then
    OK "Server 토큰이 Prod로 설정됨"
else
    WARN "Server 토큰이 Prod로 설정되지 않음"
fi

# Check if ServerSignature is set to Off
if grep -q "ServerSignature Off" $CONF_FILE; then
    OK "Server Signature가 off으로 설정됨"
else
    WARN "Server Signature가 Off로 설정되지 않음"
fi



cat $result

echo ; echo 