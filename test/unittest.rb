require "simplecov"
SimpleCov.start do
  add_filter "/coverage/" # Ignores any file containing "/vendor/" in its path.
end
puts "Hello Travis"
