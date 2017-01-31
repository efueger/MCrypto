puts "Making a test key"
%x{gpg --batch --gen-key ../test/testkey}
