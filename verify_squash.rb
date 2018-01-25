require 'csv'

directory = ARGV[1]
size = ARGV.first
csv = ARGV.last

CSV.foreach( csv, :headers => false ) do |row|
  filename = "#{row[0].split( '-' ).sort.join( '-' )}-#{size}"
  files = Dir.glob( "#{directory}/#{filename}*.png" )
  puts "Verifying #{directory}/#{filename}*.png (#{files.count})"
end



