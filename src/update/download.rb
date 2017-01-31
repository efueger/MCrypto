require 'tty-spinner'
require 'socket'

netspin = TTY::Spinner.new("Downloading Update :spinner ...", format: :pulse_2)
netspin.auto_spin

begin
  TCPSocket.new 'github.com', 80
rescue SocketError
  netspin.error("\nNo internet connection detected.")
  exit
end

%x{cd download; curl -sL https://git.io/vDTnE | tar x;}

netspin.stop('Complete')
inspin = TTY::Spinner.new("Installing Update :spinner ...", format: :bouncing_ball)
inspin.auto_spin

%x{
  cd ~/.mcrypto/update/download/
  cp MCrypto-latest-stable/src/* ~/.mcrypto/
  rm -r ~/.mcrypto/update/download/
}

inspin.stop("Installed!")
