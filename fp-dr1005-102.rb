class Dress

  attr_reader :customization_list
  attr_reader :starting_json
  attr_reader :all_lengths
  attr_reader :search_directories
  attr_reader :number_of_colors
  attr_reader :ignorable_customizations
  
  def initialize
    @name = "Column Dress"
    @customization_list = ['t2', 't3', 't4', 't6', 't22', 't27', 't29', 't31', 't33', 't35', 't44', 't51', 't58', 't60', 'b1', 'b3', 'b13', 'b20', 'a1', 'a2', 'a5']
    @number_of_colors = 17;    
    @starting_json = Hash.new { |hash,key| hash[key] = Hash.new {|hash2,key2| hash2[key2] = Hash.new } }
    @search_directories = ["/home/ubuntu/Dropbox/renderfiles/Bridesmaid Collection/11. Models and Customisations/The Column Dress and Jump Suit/Rendered PNG's/TAKE SYSTEM 6K"]
    
    @all_lengths = { "micro": "Micro-Mini", "knee": "Knee", "mini": "Mini", "midi": "Midi", "ankle": "Ankle", "maxi": "Maxi"}
    @starting_json['Micro-Mini']['default'] = { "front": { "bottom": "b5_micro_mini_flared_bottom_front",  "belt": "default_belt_front", "neckline": "t1_neckline_front" }, "back": { "bottom": "b5_micro_mini_flared_bottom_back", "belt":"default_belt_back", "neckline": "t1_neckline_back" } }
    @starting_json['Knee']['default'] = { "front": { "bottom": "b5_knee_bottom_front",  "belt": "default_belt_front", "neckline": "t1_neckline_front" }, "back": { "bottom": "b5_knee_bottom_back", "belt":"default_belt_back", "neckline": "t1_neckline_back" } }
    @starting_json['Mini']['default'] = { "front": { "bottom": "b5_mini_bottom_front",  "belt": "default_belt_front", "neckline": "t1_neckline_front" }, "back": { "bottom": "b5_mini_bottom_back", "belt":"default_belt_back", "neckline": "t1_neckline_back" } }
    @starting_json['Midi']['default'] = { "front": { "bottom": "b5_midi_bottom_front",  "belt": "default_belt_front", "neckline": "t1_neckline_front" }, "back": { "bottom": "b5_midi_bottom_back", "belt":"default_belt_back", "neckline": "t1_neckline_back" } }
    @starting_json['Ankle']['default'] = { "front": { "bottom": "default_b5_ankle_bottom_front",  "belt": "default_belt_front", "neckline": "t1_neckline_front" }, "back": { "bottom": "default_b05_ankle_bottom_back", "belt":"default_belt_back", "neckline": "t1_neckline_back" } }
    @starting_json['Maxi']['default'] = { "front": { "bottom": "b5_maxi_bottom_front",  "belt": "default_belt_front", "neckline": "t1_neckline_front" }, "back": { "bottom": "b5_maxi_bottom_front", "belt":"default_belt_back", "neckline": "t1_neckline_back" } }
  end
  
end
