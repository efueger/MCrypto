
# MCrypto Update Script
clear;

sconf=/tmp/mcrypto_install_$$

function pause()
{
   read -p "$*"
}

trap abort INT

function abort()
{
  clear;
  printf "Aborting Update! Are you sure? \n"
  pause "Press [Enter] to abort installation."
  clear;
  rm -r ~/.mcrypto/update
  exit;
}

install ()
{

  echo "Updating MCrypto..."

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
  which pv |
  if [[ $? = "1" ]]; then
    echo "Could not find pv, installing..."
    # brew install pv
  else
    echo "Found pv..."
  fi
  echo "All dependencies good to go."

  echo "Downloading Files..."
  if [[ !-d ~/.mcrypto/update/download ]]; then
    mkdir ~/.mcrypto/update/download 
  done
  ruby download.rb

  # ruby download.rb
  echo "MCryto update sucessful!"
  # read -p "Press [Enter] to reload the terminal."
  # osascript relaunchTerm.applescript

}

install
