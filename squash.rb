require 'csv'

def build_image_file_name( base_filename, input_directory, color )
  filename_to_search_for = "#{base_filename}_#{color}.png"
  results = Dir.glob("#{input_directory}/**/#{filename_to_search_for}")
  raise "unknown file #{filename_to_search_for}" if results.empty?
  "\"#{results.first}\""
  
end

def build_combine_files_command( files, side, length, color, base_filename, search_directory, output_directory )
  to_return = "convert -size 800x800 xc:transparent"
  first_file = files.first
  to_return = "#{to_return} #{build_image_file_name(first_file, search_directory, color)}"
  files[1..files.length].each do |file_name|
    to_return = "#{to_return} -composite #{build_image_file_name( file_name, search_directory, color )}"
  end

  return "#{to_return} -units PixelsPerInch -density 172 #{output_directory}/#{base_filename.split( '-' ).sort.join('-')}-#{length}-#{side}-#{color}.png"
end

if( ARGV.length < 4 )
  puts "usage: ruby squash.rb <CSV> <LENGTH> <SEARCH DIRECTORY> <OUTPUT DIRECTORY>"
else
  
  csv_file = ARGV.first
  length = ARGV[1]
  search_directory = ARGV[2]
  output_directory = ARGV.last

  CSV.foreach( csv_file, :headers => false ) do |row|
    puts ""
    puts build_combine_files_command( row[1].split( ' ' ), 'front', length, '0000', row[0], search_directory, output_directory )
  end
  
end

  #convert -size 800x800 xc:transparent jumpsuit_pants_cheeky_bottom_front_0000.png -composite default_belt_front_0000.png  -composite t2_neckline_front_0000.png -composite -density 350 results.png

  
