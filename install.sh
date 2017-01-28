#!/bin/sh

# MCrypto Install Script

clear

echo "Installing MCrypto..."

which brew |
if [[ $? = "1" ]]; then
  echo "Could not find homwbrew, installing..."
  #/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
else
  echo "Found homebrew installation... Updating"
  #brew update
fi
which gpg2 |
if [[ $? = "1" ]]; then
  echo "Could not find GPG, installing..."
  #brew install gpg2
else
  echo "Found GPG..."
fi
which dialog |
if [[ $? = "1" ]]; then
  echo "Could not find dialog, installing..."
  # brew install dialog
else
  echo "Found dialog..."
fi

echo "All dependencies good to go."

which bash 

mkdir ~/.mcrypto


#cat .aliases >> $startfile
