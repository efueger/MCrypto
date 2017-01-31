task default: %w[test]

task :test do
  ruby "test/gentestkey.rb"
  ruby "src/update/download.rb"
  ruby "src/openhelp.rb"
  ruby "src/parseforsend.rb"
  ruby "src/encrypt.rb"
  ruby "src/getkeys.rb"
end
