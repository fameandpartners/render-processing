class Dress

  attr_reader :customization_list
  attr_reader :starting_json
  attr_reader :all_lengths
  
  def initialize
    @customization_list = %w( t2 t6 t7 t22 t29 t33 t34 t35 t39 t44 t56 t60 t64 b6 b7 b21 a1 a2 a4 a5 )
    @starting_json = Hash.new { |hash,key| hash[key] = Hash.new {|hash2,key2| hash2[key2] = Hash.new } }
    @all_lengths = { "midi": "Midi", "ankle": "Ankle", "cheeky": "Cheeky", "short": "Short", "full": "Full"}
    @number_of_colors = 14;    
  
    @starting_json['Midi']['default'] = { "front": { "bottom": "jumpsuit_pants_midi_bottom_front",  "belt": "default_belt_front", "neckline": "t1_neckline_front" }, "back": { "bottom": "jumpsuit_pants_midi_bottom_back", "belt":"default_belt_back", "neckline": "t1_neckline_back" } }

    @starting_json['Ankle']['default'] = { "front": { "bottom": "jumpsuit_pants_ankle_bottom_front",  "belt": "default_belt_front", "neckline": "t1_neckline_front" }, "back": { "bottom": "jumpsuit_pants_ankle_bottom_back", "belt":"default_belt_back", "neckline": "t1_neckline_back" } }

    @starting_json['Cheeky']['default'] = { "front": { "bottom": "jumpsuit_pants_cheeky_bottom_front",  "belt": "default_belt_front", "neckline": "t1_neckline_front" }, "back": { "bottom": "jumpsuit_pants_cheeky_bottom_back", "belt":"default_belt_back", "neckline": "t1_neckline_back" } }

    @starting_json['Short']['default'] = { "front": { "bottom": "jumpsuit_pants_short_bottom_front",  "belt": "default_belt_front", "neckline": "t1_neckline_front" }, "back": { "bottom": "jumpsuit_pants_short_bottom_back", "belt":"default_belt_back", "neckline": "t1_neckline_back" } }

    @starting_json['Full']['default'] = { "front": { "bottom": "default_jumpsuit_pants_full_bottom_front",  "belt": "default_belt_front", "neckline": "t1_neckline_front" }, "back": { "bottom": "default_jumpsuit_pants_full_bottom_back", "belt":"default_belt_back", "neckline": "t1_neckline_back" } }
    
  end
  
end
