input_directory = ARGV.first
files = Dir.glob("#{input_directory}/**/*.png")

files.each do |directory_and_file_name|
  puts directory_and_file_name.split( '/' ).last
end

