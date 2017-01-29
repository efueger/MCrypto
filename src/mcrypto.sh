#!/bin/sh

temp1=/tmp/mcrypto_1_$$
temp2=/tmp/mcrypto_2_$$
temp3=/tmp/mcrypto_3_$$
dconfs=/tmp/mcrypto_dconf_$$
tempdir=/tmp/mcryptod_$$
encdir=/tmp/mcryptod_$$/.dec
decdir=/tmp/mcryptod_$$/.enc
tardir=/tmp/mcryptod_$$/.tar

clear;

trap quit INT

function quit()
{
  rm -f /tmp/mcrypto_*_$$
  rm -rf /tmp/mcryptod_*
  clear
  exit
}

function encrypt()
{
  osascript getFiles.applescript
}

mkdir $tempdir $encdir $decdir $tardir
while true; do
  cat ~/.dialogrc > $dconfs
  cp .dialogrc ~/.dialogrc
  dialog --ok-label "Select" --cancel-label "Exit"  --menu "MCrypto - Secure File Encryption" 20 40 8 🔐 "Encrypt" 🔓 "Decrypt" ↓ "Add Someone Else's Key" ↑ "Send My Key to Someone Else" + "Create a New Key" \* "Show All Keys" \? "Help" 2> $temp1
  RESULT=$(cat $temp1)
  if [[ $? = "0" ]]; then
    case $RESULT in
      🔐) encrypt ;;
      🔓) echo "decrypt" ;;
      ↓) echo "addkey" ;;
      ↑) echo "sendkey" ;;
      +) echo "makekey" ;;
      \*) echo "showkeys" ;;
      \?) helppage ;;
      *) quit ;;
    esac
  else
    quit
  fi
done
