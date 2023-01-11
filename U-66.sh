#!/bin/bash

 

. function.sh

TMP1=`SCRIPTNAME`.log

> $TMP1 
  

 

BAR

CODE [U-66] SNMP 서비스 구동 점검

cat << EOF >> $TMP1 

[양호]: SNMP 서비스를 사용하지 않는 경우

[취약]: SNMP 서비스를 사용하는 경우

EOF

BAR


# check if the snmp service is active
if systemctl is-active --quiet snmpd; then
    echo "SNMP 서비스가 활성되어 있습니다"
else
    echo "SNMP 서비스가 활성화되지 않았습니다."
fi

cat $TMP1 

echo ; echo 
 

