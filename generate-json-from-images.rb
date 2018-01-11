require 'pp'

file_names = ARGV.first

@customization_list = ['t2', 't3', 't4', 't6', 't22', 't27', 't29', 't31', 't33', 't35', 't44', 't51', 't58', 't60', 'b1', 'b3', 'b13', 'b20', 'a1', 'a2', 'a5']
@all_lengths = { "micro": "Micro-Mini", "knee": "Knee", "mini": "Mini", "midi": "Midi", "ankle": "Ankle", "maxi": "Maxi"}

@length_names = @all_lengths.map { |key_value| key_value.last }

def is_conditional_file?( splits )
  splits[1] == 'for'
end

def is_length_specific_file?( splits )
  lengths = ['ankle', 'cheeky', 'full', 'knee', 'maxi', 'micro', 'midi', 'mini','short']
  return lengths.index( splits[1] ) != nil
end

def is_default?( splits )
  return splits[0] == 'default' || splits[0] == 'jumpsuit'
end

def is_front?( splits )
  splits.last == 'front'
end

def makefilename( splits )
  splits.join( '_' )
end

def add_appropriate_layer( splits, hash )
  hash = {} if hash.nil?
  location_position = splits.length - 2
  location = splits[location_position]
  if( location == 'behind' || location == 'infront' || location == 'behindbelt' )
    hash[location] = [makefilename( splits )]
  else
    hash[location] = makefilename( splits )
  end
  return hash
end

def handle_customization_for_all_lengths( splits,json )
  @length_names.each do |length_name|
    code = splits.first
    json[length_name][code]['default'] = {} if( json[length_name][code]['default'].nil? )
    if( is_front?( splits ) )
      json[length_name][code]['default']['front'] = add_appropriate_layer( splits, json[length_name]['default']['front'] )
    else
      json[length_name][code]['default']['back'] = add_appropriate_layer( splits, json[length_name]['default']['back'] )
    end
  end
  json
end

def handle_customization_for_specific_length( splits, json, position )
    code = splits.first
    length_name = @all_lengths[splits[position].to_sym]
    json[length_name][code]['default'] = {}  if( json[length_name][code]['default'].nil? )
    if( is_front?( splits ) )
      json[length_name][code]['default']['front'] = add_appropriate_layer( splits, json[length_name]['default']['front'])
    else
      json[length_name][code]['default']['back'] = add_appropriate_layer( splits, json[length_name]['default']['back'] )
    end
    json
end


processed_files = []
final_json = Hash.new { |hash,key| hash[key] = Hash.new {|hash2,key2| hash2[key2] = Hash.new } }

File.readlines( file_names ).each do |file|
  file_without_extenions = file.split( '.' ).first
  
  split_file = file_without_extenions.split( '_' )
  if( split_file.count > 2 &&  @customization_list.index( split_file.first ) != nil )
    split_file = split_file[0..split_file.length - 2 ] #lose the color
    filename_without_color = split_file.join( '_' )
    unless( processed_files.index( filename_without_color ) )
      processed_files << filename_without_color
      if( is_conditional_file?( split_file )  )
      elsif( is_length_specific_file?( split_file ) )
        final_json = handle_customization_for_specific_length( split_file, final_json, 1 )
      elsif( is_default?( split_file ) )
        puts filename_without_color        
      else
        final_json = handle_customization_for_all_lengths(split_file, final_json)
      end
    end
  end
  
end



pp final_json
