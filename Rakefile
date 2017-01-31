task default: %w[test]

task :test do
  ruby "test/gentestkey.rb"
  ruby "src/updatechecker.rb"
  ruby "src/encrypt.rb"
  ruby "src/getkeys.rb"
end
