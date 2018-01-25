require 'csv'

directory = ARGV[1]
size = ARGV.first
csv = ARGV.last

CSV.foreach( csv, :headers => false ) do |row|
  filename = "#{row[0].split( ' ' ).sort.join( '-' )}-#{size}"
  files = Dir.glob( "#{directory}/#{file_name}*.png" )
  puts filename if files.empty?
end



