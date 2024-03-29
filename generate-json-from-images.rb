require 'pp'
require 'json'
require "./#{ARGV.first}"
require 'active_support/core_ext/hash/indifferent_access'

dress = Dress.new
file_names = ARGV.last

@all_lengths = dress.all_lengths
@length_names = @all_lengths.map { |key_value| key_value.last }

def is_conditional_file?( splits )
  splits[1] == 'for'
end

def is_length_specific_file?( splits, index = 1 )
  return @all_lengths[splits[index].to_sym] != nil
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
      json[length_name][code]['default']['front'] = add_appropriate_layer( splits, json[length_name][code]['default']['front'] )
    else
      json[length_name][code]['default']['back'] = add_appropriate_layer( splits, json[length_name][code]['default']['back'] )
    end
  end
  json
end

def handle_customization_for_specific_length( splits, json, position )
    code = splits.first
    length_name = @all_lengths[splits[position].to_sym]
    json[length_name][code]['default'] = {}  if( json[length_name][code]['default'].nil? )
    
    if( is_front?( splits ) )
      json[length_name][code]['default']['front'] = add_appropriate_layer( splits, json[length_name][code]['default']['front'])
    else
      json[length_name][code]['default']['back'] = add_appropriate_layer( splits, json[length_name][code]['default']['back'] )
    end
    
    json
end

def determine_number_of_conditional_codes( splits )
  to_return = 0
  position = 2
  while( splits[position].length < 4 || splits[position] == 'base' || splits[position] == 'default' )
    to_return += 1
    position += 1
  end

  to_return
end


def deep_copy(o)
  HashWithIndifferentAccess.new( JSON.load( o.to_json ) )
end

def handle_conditional_customization( splits, json, starting_state )
  code = splits.first
  should_print =  false
  number_of_codes = determine_number_of_conditional_codes( splits )
  conditions = splits[2..(1+number_of_codes)];
  lengths = @length_names
  if( is_length_specific_file?( splits, 2 + number_of_codes ) )
    lengths = [ @all_lengths[splits[2 + number_of_codes].to_sym] ]
  end

  lengths.each do |length_name|
    puts "#{length_name}" if should_print
    hash = deep_copy(json[length_name][code]) || HashWithIndifferentAccess.new()
    puts "hash = #{hash}" if should_print
    last_hash = HashWithIndifferentAccess.new(  )
    puts "last_hash = #{last_hash}" if should_print
    current_hash = hash
    if( conditions.last == 'base')
      conditions.pop
    end
    conditions.sort.each do |condition|
      puts "condition = #{condition}" if should_print
      current_hash[condition] =  current_hash[condition] || HashWithIndifferentAccess.new({ 'default': last_hash['default'] } )
      last_hash =  current_hash
      current_hash =  current_hash[condition]
      puts "conditions current_hash = #{current_hash}" if should_print
    end

    current_hash['default'] = deep_copy(current_hash['default']) || HashWithIndifferentAccess.new()
    puts "final current hash = #{current_hash}" if should_print
    if( is_front?( splits ) )
      current_hash['default']['front'] = add_appropriate_layer( splits, deep_copy( current_hash['default']['front'] ))
    else
      current_hash['default']['back'] = add_appropriate_layer( splits, deep_copy( current_hash['default']['back'] ) )
    end
    json[length_name][code] = deep_copy( hash )
  end
  json
end

processed_files = []

final_json = dress.starting_json

File.readlines( file_names ).each do |file|
  file_without_extenions = file.split( '.' ).first
  split_file = file_without_extenions.split( '_' )  
  split_file = split_file[0..split_file.length - 2 ] #lose the color
  filename_without_color = split_file.join( '_' )
  if( split_file.count > 2 &&  dress.customization_list.index( split_file.first ) != nil )
    unless( processed_files.index( filename_without_color ) )
      processed_files << filename_without_color
      if( is_conditional_file?( split_file )  )
        final_json = handle_conditional_customization( split_file, final_json, dress.starting_json )
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
