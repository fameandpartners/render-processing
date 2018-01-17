directory = ARGV.first
filename = ARGV.last

`convert  -trim  "#{directory}/#{filename}"  -resize x142 -background transparent -gravity Center -extent 142x142! "#{directory}/142x142/#{filename}"`
`convert  -trim  "#{directory}/#{filename}"  -chop '0x33%' +repage -resize 142x -background transparent -gravity Center -extent 142x142! "#{directory}/bottom-crop/#{filename}"` 
`convert  -trim  "#{directory}/#{filename}" -gravity SouthWest -chop '0x33%' +repage -resize 142x -background transparent -gravity Center -extent 142x142! "#{directory}/top-crop/#{filename}"`
