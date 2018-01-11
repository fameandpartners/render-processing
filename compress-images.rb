require 'thread'
input_directory = ARGV.first
output_directory = ARGV.last

number_of_threads = 4

files = Dir.glob("#{input_directory}/**/*.png")
puts files.count

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

