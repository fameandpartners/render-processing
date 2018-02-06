class Dress

  attr_reader :customization_list
  attr_reader :starting_json
  attr_reader :all_lengths
  attr_reader :search_directories
  attr_reader :number_of_colors
  attr_reader :ignorable_customizations
  
  def initialize
    @name = 'Slip Dress'
    @number_of_colors = 17;
    @customization_list = %w( t6 t9 t10 t11 t16 t18 t19 t25 t28 t45 t49 t57 b4 b14 b17 b18 a2 a5 )
    @ignorable_customizations = %w( b17 b18 )
    @starting_json = Hash.new { |hash,key| hash[key] = Hash.new {|hash2,key2| hash2[key2] = Hash.new } }
    @all_lengths = { "micro": "Micro-Mini", "knee": "Knee", "mini": "Mini", "midi": "Midi", "ankle": "Ankle", "maxi": "Maxi"}
    @search_directories = ["/home/ubuntu/Dropbox/renderfiles/Bridesmaid Collection/11. Models and Customisations/Slip Dress/Rendererd PNG's/Sides"]
    @starting_json['Micro-Mini']['default'] = { "front":
                                                  {
                                                    "bottom": "base_micro_mini_bottom_front",
                                                    "belt" : "base_micro_mini_belt_front",
                                                    "neckline": "base_neckline_front"
                                                  },
                                                "back":
                                                  {
                                                    "neckline": "base_neckline_back",
                                                    "belt": "base_micro_mini_belt_back",
                                                    "bottom": "base_micro_mini_bottom_back"
                                                  }
                                              }
    
    @starting_json['Mini']['default'] = { "front":
                                            {
                                              "bottom": "base_mini_bottom_front",
                                             "belt" : "base_mini_belt_front",
                                              "neckline": "base_neckline_front"
                                            },
                                          "back":
                                            {
                                              "neckline": "base_neckline_back",
                                             "belt": "base_mini_belt_back",
                                             "bottom": "base_midi_bottom_back"
                                            }
                                        }
    
    @starting_json['Knee']['default'] = { "front":
                                            {
                                              "bottom": "base_knee_bottom_front",
                                             "belt" : "base_knee_belt_front",
                                             "neckline": "base_neckline_front"
                                            },
                                          "back":
                                            {
                                              "neckline": "base_neckline_back",
                                             "belt": "base_knee_belt_back",                                             
                                              "bottom": "base_knee_bottom_back"
                                            }
                                        }

    

    @starting_json['Midi']['default'] = { "front":
                                            {
                                              "bottom": "base_midi_bottom_front",
                                             "belt" : "base_midi_belt_front",                                             
                                              "neckline": "base_neckline_front"
                                            },
                                          "back":
                                            {
                                              "neckline": "base_neckline_back",
                                             "belt": "base_midi_belt_back",
                                              "bottom": "base_midi_bottom_back"
                                            }
                                        }
    
    @starting_json['Ankle']['default'] = { "front":
                                             {
                                               "bottom": "base_ankle_bottom_front",
                                             "belt" : "base_ankle_belt_front", 
                                              "neckline": "base_neckline_front"
                                             },
                                           "back":
                                             {
                                               "neckline": "base_neckline_back",
                                              "belt": "base_ankle_belt_back",                                              
                                              "bottom": "base_ankle_bottom_back"
                                             }
                                         }
    
    @starting_json['Maxi']['default'] = { "front":
                                            {
                                              "bottom": "base_maxi_bottom_front",
                                            "belt" : "base_maxi_belt_front",                                              
                                              "neckline": "base_neckline_front"
                                             },
                                           "back":
                                             {
                                               "neckline": "base_neckline_back",
                                              "belt": "base_maxi_belt_back",
                                               "bottom": "base_maxi_bottom_back"
                                                  
                                             }
                                        }

  end
end
