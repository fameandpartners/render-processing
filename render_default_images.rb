require './fp-js1007-102'

dress = Dress.new
output_directory = ARGV.last
search_directory = ARGV.first

def build_image_file_name( base_filename, input_directory, color )
  filename_to_search_for = "#{base_filename}_#{color}.png"
  results = Dir.glob("#{input_directory}/**/#{filename_to_search_for}")
  raise "unknown file #{filename_to_search_for}" if results.empty?
  "\"#{results.first}\""
  
end

def build_combine_files_commands( files, side, length, color, search_directory, output_directory )
  final_filename = "#{side}-default-#{length}-#{color}.png"
  commands = []
  command = "convert #{build_image_file_name(files['bottom'], search_directory, color)} "
  [files['belt'],files['neckline']].each do |file|
    command = "#{command} #{build_image_file_name(file, search_directory, color)} -composite "
    command = "#{command} -units PixelsPerInch -density 172 -resize 800x800 \"#{output_directory}/#{final_file_name}\""
    commands << command
  end
  
  return commands
end

def build_color( color_number )
  if( color_number < 10 )
    "000#{color_number}"
  else
    "00#{color_number}"    
  end
end

dress.starting_json.each do |key,value|
  (0..14).each do |color_number|
    puts value
    puts build_combine_files_commands( value[:default][:front],
                                  'front',
                                  key.downcase.gsub( '-', '_' ),
                                  build_color( color_number ),
                                  search_directory,
                                  output_directory
                                )
  end
end
