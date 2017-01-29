
# MCrypto Install Script
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
  printf "Aborting Install! Are you sure? \n"
  pause "Press [Enter] to abort installation."
  clear;
  rm -r ~/.mcrypto
  exit;
}

install ()
{

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
  which pv |
  if [[ $? = "1" ]]; then
    echo "Could not find pv, installing..."
    # brew install pv
  else
    echo "Found pv..."
  fi
  echo "All dependencies good to go."

  echo "Copying Files..."

  mkdir ~/.mcrypto
  tar c . | pv | tar x -C ~/.mcrypto/

  case $SHELL in
    *bash) echo "Shell is BASH, Adding MCrypto to your PATH"; sfile=~/.bashrc; ;;
    *zsh) echo "Shell is ZSH, Adding MCrypto to your PATH"; sfile=~/.zshrc; ;;
  esac
  cat .tostartup >> $sfile;
  echo $PATH | grep .mcrypto |
  case $? in
    0) echo "PATH check OK" ;;
    1) al=$(cat .tostartup); clear; printf "It appears MCryto is not in your PATH, perhaps you did not enter the correct startup file?" ;;
  esac
  echo "MCryto installation sucessful!"
  read -p "Press [Enter] to reload the terminal."
  osascript relaunch_termapp.scpt

}

echo $PATH | grep .mcrypto
case $? in
  0) clear; echo "MCrypto is already installed!" ;;
  1) install ;;
esac
