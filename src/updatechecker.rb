# Check for updates
require 'tty-spinner'
require 'socket'

netspin = TTY::Spinner.new("Checking for avalible updates :spinner ...", format: :pulse_2)
netspin.auto_spin

begin
  TCPSocket.new 'github.com', 80
rescue SocketError
  netspin.error("\nNo internet connection detected.")
  exit
end
webversion = %x{wget -q -O /tmp/mcrypto_v_$$ https://raw.githubusercontent.com/AJdev23/MCrypto/latest-stable/src/currentversion.conf; cat /tmp/mcrypto_v_$$; rm /tmp/mcrypto_v_$$ }

netspin.stop('Complete')

localversion = %x{cat currentversion.conf}

if webversion == localversion then
  puts "You are up to date!"
else
  while true do
    puts "An update is avalible. Install it now? [Y / N]"
    STDOUT.flush
    res = gets.chomp
      case res
      when "y","Y"
          %x{
            cd update
            ./install-update.sh
          }
          break
        when "n","N"
          break
        else
          puts "Please answer Y or N..."
      end
  end
end
