#!/bin/sh

temp1=/tmp/mcrypto_1_$$
temp2=/tmp/mcrypto_2_$$
temp3=/tmp/mcrypto_3_$$

clear;

quit()
{
  rm -f $temp1; rm -f $temp2; rm -f $temp3
  exit;
}

w=$(tput cols)
h=$(tput lines)
buffer=10

dialog --menu "MCrypto - Secure File Encryption" 20 40 6 1 "Encrypt File" 2 "Decrypt File" 3 "Add Someone Else's Key" 4 "Send My Key to Someone Else" 5 "Create a Key" 6 "Show All Keys" 2> $temp1

if [[ $? = "0" ]]; then
  echo "pressed"
else
  if [[ -f $temp1 ]]; then
    rm $temp1
  fi
  if [[ -f $temp2 ]]; then
    rm $temp2
  fi
  if [[ -f $temp3 ]]; then
    rm $temp3
  fi
fi
