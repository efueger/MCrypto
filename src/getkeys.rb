raw = %x{gpg --list-public-keys | grep uid}
parsed = Array.new()
unparsed = raw.split("\n")

if unparsed.size > 0
  unparsed.each do |x|
    if x.include? "]"
      varstring = "]"
    else
      varstring = "d"
    end
    x.reverse!; pa = x.slice(0..(x.index(varstring) - 1)); pa.reverse!; sa = pa.strip; parsed.push(sa)

  end
  puts parsed
else
  puts "nokeys"
end
