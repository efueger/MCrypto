#!/bin/sh

VER=$(cat currentversion.conf)
mainmen=/tmp/mcrypto_1_$$
keyfile=/tmp/mcrypto_2_$$
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
  ruby encrypt.rb
}

function showall()
{
  KEYS=$(ruby getkeys.rb)
  echo $KEYS > $keyfile
  dialog --title "Public Keys" --exit-label "Main Menu" --textbox $keyfile 10 60
 }

mkdir $tempdir $encdir $decdir $tardir
ruby updatechecker.rb
while true; do
  cat ~/.dialogrc > $dconfs
  cp .dialogrc ~/.dialogrc
  dialog --title $VER --ok-label "Select" --cancel-label "Exit"  --menu "  MCrypto - Secure File Encryption" 20 40 8 🔐 "Encrypt" 🔓 "Decrypt" ↓ "Add Someone Else's Key" ↑ "Send My Key to Someone Else" + "Create a New Key" \* "Show All Keys" \? "Help" 2> $mainmen
  RESULT=$(cat $mainmen)
  if [[ $? = "0" ]]; then
    case $RESULT in
      🔐) encrypt ;;
      🔓) echo "decrypt" ;;
      ↓) echo "addkey" ;;
      ↑) echo "sendkey" ;;
      +) echo "makekey" ;;
      \*) showall ;;
      \?) helppage ;;
      *) quit ;;
    esac
  else
    quit
  fi
done
