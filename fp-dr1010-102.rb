class Dress

  attr_reader :customization_list
  attr_reader :starting_json
  attr_reader :all_lengths
  attr_reader :search_directories
  attr_reader :number_of_colors
  attr_reader :ignorable_customizations
  
  def initialize
    @name = 'Shift Dress'
    @number_of_colors = 17;
    @customization_list = %w( t9 t16 t17 t20 t21 t38 t50 t57 t59 t61 b4 b16 b21 a1 a2 a5 )
    @ignorable_customizations = %w( a4 )
    @starting_json = Hash.new { |hash,key| hash[key] = Hash.new {|hash2,key2| hash2[key2] = Hash.new } }
    @all_lengths = { "micro": "Micro-Mini", "knee": "Knee", "mini": "Mini", "midi": "Midi", "ankle": "Ankle", "maxi": "Maxi"}
    @search_directories = ["/home/ubuntu/Dropbox/renderfiles/Bridesmaid Collection/11. Models and Customisations/Shift Dress/Rendered PNGs/sides"]
    @starting_json['Micro-Mini']['default'] = { "front":
                                                  {
                                                    "bottom": "base_micro_mini_bottom_front",
                                                    "neckline": "base_neckline_front"
                                                  },
                                                "back":
                                                  {
                                                    "neckline": "base_neckline_back",
                                                    "bottom": "base_micro_mini_bottom_back"
                                                  }
                                              }
    
    @starting_json['Mini']['default'] = { "front":
                                            {
                                              "bottom": "base_mini_bottom_front",
                                              "neckline": "base_neckline_front"
                                            },
                                          "back":
                                            {
                                              "neckline": "base_neckline_back",
                                             "bottom": "base_midi_bottom_back"
                                            }
                                        }
    
    @starting_json['Knee']['default'] = { "front":
                                            {
                                              "bottom": "base_knee_bottom_front",
                                              "neckline": "base_neckline_front"
                                            },
                                          "back":
                                            {
                                              "neckline": "base_neckline_back",
                                              "bottom": "base_knee_bottom_back"
                                            }
                                        }

    

    @starting_json['Midi']['default'] = { "front":
                                            {
                                              "bottom": "base_midi_bottom_front",
                                              "neckline": "base_neckline_front"
                                            },
                                          "back":
                                            {
                                              "neckline": "base_neckline_back",
                                              "bottom": "base_midi_bottom_back"
                                            }
                                        }
    
    @starting_json['Ankle']['default'] = { "front":
                                             {
                                              "bottom": "base_ankle_bottom_front",
                                              "neckline": "base_neckline_front"
                                             },
                                           "back":
                                             {
                                               "neckline": "base_neckline_back",
                                              "bottom": "base_ankle_bottom_back"
                                             }
                                         }
    
    @starting_json['Maxi']['default'] = { "front":
                                             {
                                              "neckline": "base_neckline_front"
                                             },
                                           "back":
                                             {
                                               "neckline": "base_neckline_back"
                                             }
                                        }

  end
end
