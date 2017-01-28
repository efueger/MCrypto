#!/bin/sh

temp1=/tmp/mcrypto_1_$$
temp2=/tmp/mcrypto_2_$$
temp3=/tmp/mcrypto_3_$$

clear;

quit()
{
  if [[ -f $temp1 ]]; then
    rm $temp1
  fi
  if [[ -f $temp2 ]]; then
    rm $temp2
  fi
  if [[ -f $temp3 ]]; then
    rm $temp3
  fi
  clear;
  exit;
}


dialog --menu "MCrypto - Secure File Encryption" 20 40 6 1 "Encrypt File" 2 "Decrypt File" 3 "Add Someone Else's Key" 4 "Send My Key to Someone Else" 5 "Create a Key" 6 "Show All Keys" 2> $temp1

if [[ $? = "0" ]]; then
  RESULT=$(cat $temp1)
  case $RESULT in
  	1) echo "encrypt" ;;
  	2) echo "decrypt" ;;
  	3) echo "addkey" ;;
  	4) echo "sendkey" ;;
  	5) echo "makekey" ;;
  	6) echo "showkeys" ;;
  	*) exit ;;
  esac
else
  quit
fi
