require './fp-dr1002-102'
require 'thread'

def find_files( directories_to_search, customization_code )
  return find_specific_files( "#{customization_code}_*.png" )
end

def find_specific_files( file_pattern )
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

def find_files_for_defaults( data )
  to_return = []
  to_return += find_files_for_defaults( "#{data[:bottom]}_*.png" )
  to_return += find_files_for_defaults( "#{data[:belt]}_*.png" )
  to_return += find_files_for_defaults( "#{data[:neckline]}_*.png" )

  return to_return
end

dress = Dress.new

input_directory = ARGV.first
output_directory = ARGV.last
number_of_threads = 0


file_set = []
dress.customization_list.each do |customization_code|
  files = find_files( dress.search_directories, customization_code )
  raise "#{customization_code} is empty" if files.empty?
  file_set = file_set + files
end

dress.starting_json.each do |length, value|
  file_set += find_files_for_defaults( value['default'][:front] )
  file_set += find_files_for_defaults( value['default'][:back] )
end

puts file_set

threads = []
semaphore = Mutex.new

(1..number_of_threads).each do |thread_num|
  
  threads << Thread.new do
    file_name = "start"
    directory_and_file_name = nil
    while( file_name != nil ) do
      semaphore.synchronize do
        unless( files.empty? )
          directory_and_file_name = files.pop
          file_name = directory_and_file_name.split( '/' ).last
        else
          file_name = nil
        end
      end
      unless file_name.nil?
        puts "(#{thread_num}): #{file_name}"         
        directory_name = "/home/ubuntu/s3/renders/#{file_name.split( '_' ).first.downcase}"
        Dir.mkdir(directory_name) unless File.exists?(directory_name)
        puts `convert -units PixelsPerInch -density 172 "#{directory_and_file_name}" -resize 800x800 "#{directory_name}/#{file_name.downcase}"`
      end
    end
  end
end

threads.each do |thread|
  thread.join
end

