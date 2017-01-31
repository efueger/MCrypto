raw = %x{gpg --list-public-keys | grep uid}
unparsed = Array.new
parsed = Array.new()
unparsed = raw.split("\n")
if unparsed.size > 0
  unparsed.each do |x|
    if x.include? "]"
      x.reverse!; pa = x.slice(0..(x.index("]") - 1)); pa.reverse!; sa = pa.strip; parsed.push(sa)
    else
      x.reverse!; pa = x.slice(0..(x.index("d") - 1)); pa.reverse!; sa = pa.strip; parsed.push(sa)
    end
  end
  puts parsed
else
  puts "nokeys"
end
