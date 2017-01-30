if RUBY_PLATFORM == "x86_64-darwin16"
  unparsedFiles = %x{osascript getFiles.applescript}
  puts unparsedFiles
else
  puts "NOT A MAC!"
end
