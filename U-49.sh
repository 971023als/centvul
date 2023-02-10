#!/bin/bash

 

. function.sh

 

TMP1=`SCRIPTNAME`.log

> $TMP1
 

BAR

CODE [U-49] 불필요한 계정 제거

cat << EOF >> $result

[양호]: 불필요한 계정이 존재하지 않는 경우

[취약]: 불필요한 계정이 존재하는 경우

EOF

BAR

results=$(cat /etc/passwd | grep "lp\|uucp\|nuucp")

if [ -n "$results" ]; then
  WARN "사용자 이름 lp, uucp 또는 nuucp를 가진 하나 이상의 시스템 계정이 있습니다."
  INFO "이러한 계정은 시스템 구성에 따라 로그인할 수 있습니다."
else
  OK "사용자 이름 lp, uucp 또는 nuucp를 가진 시스템 계정이 없습니다."
fi


# 기본 계정 목록 지정
default_accounts=(
  "root"
  "bin"
  "daemon"
  "adm"
  "lp"
  "sync"
  "shutdown"
  "halt"
  "ubuntu"
  "messagebus"
  "syslog"
  "avahi"
  "kernoops"
  "whoopsie"
  "colord"
  "systemd-network"
  "systemd-resolve"
  "systemd-timesync"
  "dbus"
  "rpc"
  "rpcuser"
  "haldaemon"
  "apache"
  "postfix"
  "gdm"
  "sys"
  "games"
  "man"
  "news"
  "uucp"
  "proxy"
  "www-data"
  "backup"
  "list"
  "irc"
  "gnarts"
  "nobody"
  "_apt"
  "tss"
  "uuidd"
  "tcpdump"
  "avahi-autoipad"
  "usbmux"
  "rtkit"
  "dnsmasq"
  "cups-pk-helper"
  "speech-dispatcher"
  "saned"
  "nm-openvpn"
  "hplip"
  "geoclue"
  "pulse"
  "gnone-initial-setup"
  "systmd-coredump"
  "fwupd-refresh"
  "adiosl"
  "mysql"
  "cuvrid"
  "user"
)

# 셸이 bash로 설정된 사용자 목록을 /etc/passwd에서 가져옵니다
user_list=$(cat /etc/passwd | grep bash | awk -F: '{print $1}')

# 사용자 목록을 순환
for user in $user_list; do
  # Check if the user is a default account
  if echo "$default_accounts" | grep -qw "$user"; then
  else
    INFO "용도가 의심되는 계정 발견: $user"
  fi
done

 

cat $result

echo ; echo
