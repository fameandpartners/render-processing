require './fp-dr1010-102'
dress = Dress.new

directory = dress.search_directories.first


['Front', 'Back' ].each do |subdirectory|
  file_list = []
  
  files = Dir.glob("#{directory}/#{subdirectory}/*.png")

  files.each do |file|
    split_file = file.split( '.' ).first.split( '_' )
    split_file.pop
    file_list << split_file.join( '_' )
  end

  file_list = file_list.uniq

  file_list.each do |part_of_file|
    puts "Verifying #{part_of_file}"
    puts "Missing colors for #{part_of_file}" unless Dir.glob("#{directory}/#{subdirectory}/#{part_of_file}_00*.png").count == (dress.number_of_colors + 1)
  end
end

