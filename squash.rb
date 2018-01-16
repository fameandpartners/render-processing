require 'csv'

def build_image_file_name( base_filename, input_directory, color )
  filename_to_search_for = "#{base_filename}_#{color}.png"
  results = Dir.glob("#{input_directory}/**/#{filename_to_search_for}")
  raise "unknown file #{filename_to_search_for}" if results.empty?
  "\"#{results.first}\""
  
end



def build_combine_files_commands( files, side, length, color, base_filename, search_directory, output_directory, temp_directory )
  final_file_name = "#{base_filename.split( '-' ).sort.join('-')}-#{length}-#{side}-#{color}.png"
  temp_final_file = "\"#{temp_directory}/#{final_file_name}\""
  commands = []
  if( files.length == 1 )
    commands << "cp #{build_image_file_name( files.first, search_directory, color )} #{temp_final_file}"
    commands << "convert -units PixelsPerInch -density 172  \"#{temp_final_file}\" -resize 800x800 \"#{temp_final_file}\""
    commands << "mv  \"#{temp_final_file}\" \"#{output_directory}/#{final_file_name}\""
  else
    command = "convert #{build_image_file_name(files.first, search_directory, color)} "
    files[1..files.length].each do |file|
      command = "#{command} #{build_image_file_name(file, search_directory, color)} -composite "
    end
    command = "#{command} -units PixelsPerInch -density 172 -resize 800x800 \"#{output_directory}/#{final_file_name}\""
    commands << command
  end
  

  
  return commands
end

def run( command_sets )
  threads = []
  semaphore = Mutex.new
  number_of_threads = 4

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

def build_color( color_number )
  if( color_number < 10 )
    "000#{color_number}"
  else
    "00#{color_number}"    
  end
end

if( ARGV.length < 4 )
  puts "usage: ruby squash.rb <CSV> <LENGTH> <SEARCH DIRECTORY> <OUTPUT DIRECTORY> <TEMP DIRECTORY>"
else
  puts Time.now
  csv_file = ARGV.first
  length = ARGV[1]
  search_directory = ARGV[2]
  output_directory = ARGV[3]
  temp_directory = ARGV.last
  command_sets = []
  (0..14).each do |color|
    CSV.foreach( csv_file, :headers => false ) do |row|
      if( row.length > 2 )
        command_sets << build_combine_files_commands( row[1].split( ' ' ),
                                                      'front',
                                                      length,
                                                      build_color(color),
                                                      row[0],
                                                      search_directory,
                                                      output_directory,
                                                      temp_directory )
        command_sets << build_combine_files_commands( row[2].split( ' ' ),
                                                      'back',
                                                      length,
                                                      build_color(color),
                                                      row[0],
                                                      search_directory,
                                                      output_directory,
                                                      temp_directory )
        
      end
    end
  end
  run( command_sets )
end



  
#convert -size 800x800 xc:transparent jumpsuit_pants_cheeky_bottom_front_0000.png -composite default_belt_front_0000.png  -composite t2_neckline_front_0000.png -composite -density 350 results.png


