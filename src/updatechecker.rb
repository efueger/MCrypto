# Check for updates

puts "Checking for avalible updates..."
webversion = %x{wget -q -O /tmp/mcrypto_v_$$ https://raw.githubusercontent.com/AJdev23/MCrypto/latest-stable/src/currentversion.conf; cat /tmp/mcrypto_v_$$; rm /tmp/mcrypto_v_$$ }
puts webversion
