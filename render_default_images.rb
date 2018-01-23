require './fp-dr1003-102'

dress = Dress.new
output_directory = ARGV.first
search_directory = dress.search_directories.first

def build_image_file_name( base_filename, input_directory, color )
  filename_to_search_for = "#{base_filename}_#{color}.png"
  results = Dir.glob("#{input_directory}/**/#{filename_to_search_for}")
  raise "unknown file #{filename_to_search_for}" if results.empty?
  "\"#{results.first}\""
  
end

def build_combine_files_commands( files, side, length, color, search_directory, output_directory )
  final_file_name = "default-#{length}-#{side}-#{color}.png"
  commands = []
  command = "convert #{build_image_file_name(files[:bottom], search_directory, color)} "
  [files[:belt],files[:neckline]].each do |file|
    command = "#{command} #{build_image_file_name(file, search_directory, color)} -composite "
    
  end
  command = "#{command} -units PixelsPerInch -density 172 -resize 800x800 \"#{output_directory}/#{final_file_name}\""
  commands << command  
  return commands
end

def build_color( color_number )
  if( color_number < 10 )
    "000#{color_number}"
  else
    "00#{color_number}"    
  end
end

def run( command_sets )
  threads = []
  semaphore = Mutex.new
  number_of_threads = 8

  (1..number_of_threads).each do |thread_num|
    
    threads << Thread.new do
      commands = []
      while( commands != nil ) do
        semaphore.synchronize do
          unless( command_sets.empty? )
            commands = command_sets.pop
          else
            commands = nil
          end
        end
        unless( commands.nil? )
          puts "(#{thread_num}): #{commands.first}" 
          commands.each do |command|
            results =`#{command}`
            puts results unless results.strip.empty?
          end
        end
      end
    end
  end
  threads.each do |thread|
    thread.join
  end
  puts Time.now
end

command_set = []
dress.starting_json.each do |key,value|
  (0..dress.number_of_colors).each do |color_number|
    command_set <<  build_combine_files_commands( value['default'][:front],
                                                  'front',
                                                  key.downcase.gsub( '-', '_' ),
                                                  build_color( color_number ),
                                                  search_directory,
                                                  output_directory
                                                )
    command_set << build_combine_files_commands( value['default'][:back],
                                                 'back',
                                                 key.downcase.gsub( '-', '_' ),
                                                 build_color( color_number ),
                                                 search_directory,
                                                 output_directory
                                               )
    
  end
end


run( command_set )
