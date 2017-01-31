# Check for updates
require 'tty-spinner'
require 'socket'
require 'colorize'

netspin = TTY::Spinner.new("Checking for avalible updates :spinner ...".blue, format: :pulse_2)
netspin.auto_spin

begin
  TCPSocket.new 'github.com', 80
rescue SocketError
  netspin.error("\nNo internet connection detected.".red)
  exit
end
webversion = %x{wget -q -O /tmp/mcrypto_v_$$ https://raw.githubusercontent.com/AJdev23/MCrypto/latest-stable/src/currentversion.conf; cat /tmp/mcrypto_v_$$; rm /tmp/mcrypto_v_$$ }
webversion.strip!
netspin.stop('Complete!'.green)

localversion = %x{cat ~/.mcrypto/currentversion.conf}
localversion.strip!

if webversion == localversion then
  puts "You are up to date!".green
else
  while true do
    puts "An update is avalible. Install it now? [Y / N]".yellow
    STDOUT.flush
    res = gets.chomp
      case res
      when "y","Y"
          %x{
            cd ~/.mcrypto/update
            ./install-update.sh
          }
          break
        when "n","N"
          break
        else
          puts "Please answer Y or N...".red
      end
  end
end
