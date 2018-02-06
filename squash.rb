require 'csv'
require './fp-dr1006-102'


def find_specific_files( directories_to_search, file_pattern )
  to_return = []
  directories_to_search.each do |directory|
    if( to_return.empty? )
      files = Dir.glob("#{directory}/**/#{file_pattern}")
      to_return = files
    end
  end
  
  raise "No files for file pattern #{file_pattern}"  if to_return.empty?
  return to_return
end

def build_image_file_name( base_filename, input_directories, color )
  filename_to_search_for = "#{base_filename}_#{color}.png"
  results = find_specific_files( input_directories, filename_to_search_for )
  raise "unknown file #{filename_to_search_for}" if results.empty?
  "\"#{results.first}\""
  
end



def build_combine_files_commands( files, side, length, color, base_filename, search_directories, output_directory, temp_directory )
  final_file_name = "#{base_filename.split( '-' ).sort.join('-')}-#{length}-#{side}-#{color}.png"
  temp_final_file = "\"#{temp_directory}/#{final_file_name}\""
  commands = []
  if( files.length == 1 )
    commands << "cp #{build_image_file_name( files.first, search_directories, color )} #{temp_final_file}"
    commands << "convert -units PixelsPerInch -density 172  \"#{temp_final_file}\" -resize 800x800 \"#{temp_final_file}\""
    commands << "mv  \"#{temp_final_file}\" \"#{output_directory}/#{final_file_name}\""
  else
    command = "convert #{build_image_file_name(files.first, search_directories, color)} "
    files[1..files.length].each do |file|
      command = "#{command} #{build_image_file_name(file, search_directories, color)} -composite "
    end
    command = "#{command} -units PixelsPerInch -density 172 -resize 800x800 \"#{output_directory}/#{final_file_name}\""
    commands << command
  end
  

  
  return commands
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

def build_color( color_number )
  if( color_number < 10 )
    "000#{color_number}"
  else
    "00#{color_number}"    
  end
end

if( ARGV.length < 3 )
  puts "usage: ruby squash.rb <CSV> <LENGTH> <OUTPUT DIRECTORY> <TEMP DIRECTORY>"
else
  puts Time.now
  dress = Dress.new
  search_directories = dress.search_directories
  csv_file = ARGV.first
  length = ARGV[1]
  output_directory = ARGV[2]
  temp_directory = ARGV.last
  command_sets = []
  (0..dress.number_of_colors).each do |color|
    CSV.foreach( csv_file, :headers => false ) do |row|
      if( row.length > 2 )
        command_sets << build_combine_files_commands( row[1].split( ' ' ),
                                                      'front',
                                                      length,
                                                      build_color(color),
                                                      row[0],
                                                      search_directories,
                                                      output_directory,
                                                      temp_directory )
        command_sets << build_combine_files_commands( row[2].split( ' ' ),
                                                      'back',
                                                      length,
                                                      build_color(color),
                                                      row[0],
                                                      search_directories,
                                                      output_directory,
                                                      temp_directory )
        
      end
    end
  end
  run( command_sets )
end



  
#convert -size 800x800 xc:transparent jumpsuit_pants_cheeky_bottom_front_0000.png -composite default_belt_front_0000.png  -composite t2_neckline_front_0000.png -composite -density 350 results.png


