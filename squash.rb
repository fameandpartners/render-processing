require 'csv'

def build_image_file_name( base_filename, input_directory, color )
  filename_to_search_for = "#{base_filename}_#{color}.png"
  results = Dir.glob("#{input_directory}/**/#{filename_to_search_for}")
  raise "unknown file #{filename_to_search_for}" if results.empty?
  "\"#{results.first}\""
  
end

def composite_command( base_file, layer_file, output_file )
  "composite -gravity center -quality 100 #{layer_file} #{base_file} #{output_file}"
end


def build_combine_files_commands( files, side, length, color, base_filename, search_directory, output_directory, temp_directory )
  final_file_name = "#{base_filename.split( '-' ).sort.join('-')}-#{length}-#{side}-#{color}.png"
  temp_final_file = "\"#{temp_directory}/#{final_file_name}\""
  commands = []
  if( files.length == 1 )
    commands << "cp #{build_image_file_name( files.first, search_directory, color )} #{temp_final_file}"
  else
    commands << composite_command( build_image_file_name( files[0], search_directory, color ),
                                   build_image_file_name( files[1],search_directory, color),
                                   temp_final_file )
    files[2..files.length].each do |layer_file|
      commands << composite_command( temp_final_file,
                                     build_image_file_name( layer_file,search_directory, color),
                                     temp_final_file )
    end
  end
  

  commands << "convert -units PixelsPerInch -density 172  \"#{temp_final_file}\" -resize 800x800 \"#{temp_final_file}\""
  commands << "mv  \"#{temp_final_file}\" \"#{output_directory}/#{final_file_name}\""
  
  return commands
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
  CSV.foreach( csv_file, :headers => false ) do |row|
    if( row.length > 2 )
      command_sets << build_combine_files_commands( row[1].split( ' ' ),
                                                    'front',
                                                    length,
                                                    '0000',
                                                    row[0],
                                                    search_directory,
                                                    output_directory,
                                                    temp_directory )
      command_sets << build_combine_files_commands( row[2].split( ' ' ),
                                                    'back',
                                                    length,
                                                    '0000',
                                                    row[0],
                                                    search_directory,
                                                    output_directory,
                                                    temp_directory )
      
    end
  end
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
        puts "(#{thread_num}): #{commands.first}"         
        commands.each do |command|
          results =`#{command}`
          puts results unless results.strip.empty?
        end
      end
    end
  end
  threads.each do |thread|
    thread.join
  end
  puts Time.now
  
end


#convert -size 800x800 xc:transparent jumpsuit_pants_cheeky_bottom_front_0000.png -composite default_belt_front_0000.png  -composite t2_neckline_front_0000.png -composite -density 350 results.png


