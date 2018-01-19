base_director  = ARGV.first
list_of_files = ARGV[1]
output_directory = ARGV.last

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

Dir.mkdir("#{output_directory}/142x142") unless File.exists?("#{output_directory}/142x142")
Dir.mkdir("#{output_directory}/bottom-crop") unless File.exists?("#{output_directory}/bottom-crop")
Dir.mkdir("#{output_directory}/top-crop") unless File.exists?("#{output_directory}/top-crop")

commands = []
File.readlines( list_of_files ).each do |file_line|
  filename = "#{base_director}/#{file_line.split( ' ' ).last}"
  command_set = []
  output_file_name = filename.split( '/' ).last
  command_set << "convert  -trim  \"#{filename}\"  -resize x142 -background transparent -gravity Center -extent 142x142! \"#{output_directory}/142x142/#{output_file_name}\""
  command_set << "convert  -trim \"#{filename}\"  -chop '0x33%' +repage -resize 142x -background transparent -gravity Center -extent 142x142! \"#{output_directory}/bottom-crop/#{output_file_name}\"" 
  command_set << "convert  -trim  \"#{filename}\" -gravity SouthWest -chop '0x33%' +repage -resize 142x -background transparent -gravity Center -extent 142x142! \"#{output_directory}/top-crop/#{output_file_name}\""
  commands << command_set
end

run( command_set )
