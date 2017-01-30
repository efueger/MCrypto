raw = %x{gpg --list-public-keys | grep uid}
puts raw
