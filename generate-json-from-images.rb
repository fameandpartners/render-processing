require 'pp'
require 'json'

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

def handle_conditional_customization( splits, json )
  code = splits.first
  number_of_codes = splits.length - 5
  conditions = splits[2..(2+number_of_codes)];
  @length_names.each do |length_name|
    hash = {}
    current_hash = hash
    conditions.each do |condition|
      condition = 'default' if condition == 't1'
      current_hash[condition] = {}
      current_hash = current_hash[condition]
    end
    current_hash['default'] = {}
    if( is_front?( splits ) )
      current_hash['default']['front'] = add_appropriate_layer( splits, current_hash['default']['front'])
    else
      current_hash['default']['back'] = add_appropriate_layer( splits, current_hash['default']['back'] )
    end
    json[length_name][code] = hash
  end
  
  json
end

processed_files = []
final_json = Hash.new { |hash,key| hash[key] = Hash.new {|hash2,key2| hash2[key2] = Hash.new } }
@all_lengths = { "micro": "Micro-Mini", "knee": "Knee", "mini": "Mini", "midi": "Midi", "ankle": "Ankle", "maxi": "Maxi"}
final_json['Micro-Mini']['default'] = { "front": { "bottom": "b5_micro_mini_flared_bottom_front",  "belt": "default_belt_front", "neckline": "t1_neckline_front" }, "back": { "bottom": "b5_micro_mini_flared_bottom_back", "belt":"default_belt_back", "neckline": "t1_neckline_back" } }
final_json['Knee']['default'] = { "front": { "bottom": "b5_knee_bottom_front",  "belt": "default_belt_front", "neckline": "t1_neckline_front" }, "back": { "bottom": "b5_knee_bottom_back", "belt":"default_belt_back", "neckline": "t1_neckline_back" } }
final_json['Mini']['default'] = { "front": { "bottom": "b5_mini_bottom_front",  "belt": "default_belt_front", "neckline": "t1_neckline_front" }, "back": { "bottom": "b5_mini_bottom_back", "belt":"default_belt_back", "neckline": "t1_neckline_back" } }
final_json['Midi']['default'] = { "front": { "bottom": "b5_midi_bottom_front",  "belt": "default_belt_front", "neckline": "t1_neckline_front" }, "back": { "bottom": "b5_midi_bottom_back", "belt":"default_belt_back", "neckline": "t1_neckline_back" } }
final_json['Ankle']['default'] = { "front": { "bottom": "default_b5_ankle_bottom_front",  "belt": "default_belt_front", "neckline": "t1_neckline_front" }, "back": { "bottom": "default_b05_ankle_bottom_back", "belt":"default_belt_back", "neckline": "t1_neckline_back" } }
final_json['Maxi']['default'] = { "front": { "bottom": "b5_maxi_bottom_front",  "belt": "default_belt_front", "neckline": "t1_neckline_front" }, "back": { "bottom": "b5_maxi_bottom_front", "belt":"default_belt_back", "neckline": "t1_neckline_back" } }


File.readlines( file_names ).each do |file|
  file_without_extenions = file.split( '.' ).first
  split_file = file_without_extenions.split( '_' )  
  split_file = split_file[0..split_file.length - 2 ] #lose the color
  filename_without_color = split_file.join( '_' )

  if( split_file.count > 2 &&  @customization_list.index( split_file.first ) != nil )
    unless( processed_files.index( filename_without_color ) )
      processed_files << filename_without_color
      if( is_conditional_file?( split_file )  )
        final_json = handle_conditional_customization( split_file, final_json )
      elsif( is_length_specific_file?( split_file ) )
        final_json = handle_customization_for_specific_length( split_file, final_json, 1 )
      else
        final_json = handle_customization_for_all_lengths(split_file, final_json)
      end
    end
  end
  if( is_default?( split_file ) )
#    puts filename_without_color        
  end
  
end



puts final_json.to_json
