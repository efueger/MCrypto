raw = %x{gpg --list-public-keys | grep uid}
unparsed = Array.new
parsed = Array.new()
unparsed = raw.split("\n")
unparsed.each { |x| x.reverse!; pa = x.slice(0..(x.index(']') - 1)); pa.reverse!; sa = pa.strip; parsed.push(sa)}
puts parsed
