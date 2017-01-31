#!/bin/sh

VER=$(cat ~/.mcrypto/currentversion.conf)
mainmen=/tmp/mcrypto_1_$$
keyfile=/tmp/mcrypto_2_$$
nokeymen=/tmp/mcrypto_3_$$
sends=/tmp/mcrypto_4_$$
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
  ruby ~/.mcrypto/encrypt.rb
}

function sendkey()
{
  ruby ~/.mcrypto/getkeys.rb > $keyfile
  KEYS=$(cat $keyfile)
  if [[ $KEYS == "nokeys" ]]; then
    dialog --ok-label "Select" --cancel-label "Main Menu" --menu "No Keys Avalible!" 20 40 8  + "Create a New Key" ↓ "Add Someone Else's Key" 2> $nokeymen
    RESULT=$(cat $nokeymen)
    case $RESULT in
      +) echo "makekey" ;;
      ↓) echo "addkey" ;;
    esac
  else
    ruby ~/.mcrypto/parseforsend.rb > $sends
    SENDKEY=$(cat $sends)
    dialog --exit-label "Main Menu" --menu "Choose a Key to Send" 20 90 80 1 "dude"
  fi
}

function showall()
{
  ruby ~/.mcrypto/getkeys.rb > $keyfile
  KEYS=$(cat $keyfile)
  if [[ $KEYS == "nokeys" ]]; then
    dialog --ok-label "Select" --cancel-label "Main Menu" --menu "No Keys Avalible!" 20 40 8  + "Create a New Key" ↓ "Add Someone Else's Key" 2> $nokeymen
    RESULT=$(cat $nokeymen)
    case $RESULT in
      +) echo "makekey" ;;
      ↓) echo "addkey" ;;
    esac
  else
    dialog --title "Public Keys" --exit-label "Main Menu" --textbox $keyfile 20 90
  fi
 }

mkdir $tempdir $encdir $decdir $tardir
ruby ~/.mcrypto/updatechecker.rb
while true; do
  cat ~/.dialogrc > $dconfs
  cp ~/.mcrypto/.dialogrc ~/.dialogrc
  dialog --title "Version: $VER" --ok-label "Select" --cancel-label "Exit"  --menu "  MCrypto - Secure File Encryption" 20 40 8 🔐 "Encrypt" 🔓 "Decrypt" ↓ "Add Someone Else's Key" ↑ "Send My Key to Someone Else" + "Create a New Key" \* "Show All Keys" \? "Help" 2> $mainmen
  RESULT=$(cat $mainmen)
  if [[ $? = "0" ]]; then
    case $RESULT in
      🔐) encrypt ;;
      🔓) echo "decrypt" ;;
      ↓) echo "addkey" ;;
      ↑) sendkey ;;
      +) echo "makekey" ;;
      \*) showall ;;
      \?) ruby ~/.mcrypto/openhelp.rb ;;
      *) quit ;;
    esac
  else
    quit
  fi
done
