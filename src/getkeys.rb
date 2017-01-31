raw = %x{gpg --list-public-keys | grep uid}
unparsed = Array.new
parsed = Array.new()
if !raw.nil? || raw.empty?
  unparsed = raw.split("\n")
  unparsed.each do |x|
    x.reverse!; pa = x.slice(0..(x.index("]") - 1)); pa.reverse!; sa = pa.strip; parsed.push(sa)
  end
  puts parsed
else
  puts "nokeys"
end
