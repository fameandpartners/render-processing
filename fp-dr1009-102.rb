class Dress

  attr_reader :customization_list
  attr_reader :starting_json
  attr_reader :all_lengths
  attr_reader :search_directories
  attr_reader :number_of_colors
  attr_reader :ignorable_customizations
  
  def initialize
    @name = 'Tri Cup'
    @number_of_colors = 17;
    @customization_list = %w( t7 t14 t22 t26 t33 t54 b5 b9 b12 b14 b15 a1 a4 a5 a6 )
    @ignorable_customizations = %w( a4 )
    @starting_json = Hash.new { |hash,key| hash[key] = Hash.new {|hash2,key2| hash2[key2] = Hash.new } }
    @all_lengths = { "micro": "Micro-Mini", "knee": "Knee", "mini": "Mini", "midi": "Midi", "ankle": "Ankle", "maxi": "Maxi"}
    @search_directories = ["/home/ubuntu/Dropbox/renderfiles/Bridesmaid Collection/11. Models and Customisations/Tricup/Rendered Png's"]
    @starting_json['Micro-Mini']['default'] = { "front":
                                                  {
                                                    "bottom": "base_micro_mini_bottom_front",
                                                    "belt": "base_belt_front",                                                   
                                                    "neckline": "base_neckline_front"
                                                  },
                                                "back":
                                                  {
                                                    "bottom": "base_neckline_back",
                                                    "belt": "base_belt_back",
                                                    "neckline": "base_micro_mini_bottom_back"
                                                  }
                                              }
    
    @starting_json['Mini']['default'] = { "front":
                                            {
                                              "bottom": "base_mini_bottom_front",
                                              "belt": "base_belt_front",                                                   
                                              "neckline": "base_neckline_front"
                                            },
                                          "back":
                                            {
                                              "bottom": "base_neckline_back",
                                             "belt": "base_belt_back",
                                             "neckline": "base_midi_bottom_back"
                                            }
                                        }
    
    @starting_json['Knee']['default'] = { "front":
                                            {
                                              "bottom": "base_knee_bottom_front",
                                              "belt": "base_belt_front",                                                   
                                              "neckline": "base_neckline_front"
                                            },
                                          "back":
                                            {
                                              "bottom": "base_neckline_back",
                                             "belt": "base_belt_back",
                                              "neckline": "base_knee_bottom_back"
                                            }
                                        }

    

    @starting_json['Midi']['default'] = { "front":
                                            {
                                              "bottom": "base_midi_bottom_front",
                                              "belt": "base_belt_front",                                                   
                                              "neckline": "base_neckline_front"
                                            },
                                          "back":
                                            {
                                              "bottom": "base_neckline_back",
                                             "belt": "base_belt_back",
                                              "neckline": "base_midi_bottom_back"
                                            }
                                        }
    
    @starting_json['Ankle']['default'] = { "front":
                                             {
                                              "bottom": "base_ankle_bottom_front",
                                              "belt": "base_belt_front",                                                   
                                              "neckline": "base_neckline_front"
                                             },
                                           "back":
                                             {
                                               "bottom": "base_neckline_back",
                                              "belt": "base_belt_back",
                                              "neckline": "base_ankle_bottom_back"
                                             }
                                         }
    
    @starting_json['Maxi']['default'] = { "front":
                                            {
                                              "bottom": "base_maxi_bottom_front",
                                              "belt": "base_belt_front",                                                   
                                              "neckline": "base_neckline_front"
                                            },
                                          "back":
                                            {
                                              "bottom": "base_neckline_back",
                                             "belt": "base_belt_back",
                                              "neckline": "base_maxi_bottom_back"
                                            }
                                        }

  end
end
