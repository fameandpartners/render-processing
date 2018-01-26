dress_id = ARGV.first
require "./#{dress_id}"

def verify_results( dress, results, image_size )
  dress.all_lengths.keys.each do |length|
    length_count = (results.select{ |file| !file.index( length.to_s ).nil? }).count
    if( length_count < 10000 )
      puts "#{length} is missing items for image size #{image_size}" 
    end
  end
end

dress = Dress.new


["800x800", "142x142", "bottom-crop", "top-crop"].each do |image_size|
  puts "Verify #{image_size}"
  results = `aws s3 ls s3://mkt-fameandpartners/renders/composites/#{dress_id.downcase}/#{image_size} --recursive`
  results = results.split("\n")
  puts "Total results: #{results.length}'
  verify_results( dress,results, image_size )
end

