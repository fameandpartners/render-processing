class Dress

  attr_reader :customization_list
  attr_reader :starting_json
  attr_reader :all_lengths
  attr_reader :search_directories
  attr_reader :number_of_colors
  attr_reader :ignorable_customizations
  
  def initialize
    @name = 'Classic Wrap Dress'
    @number_of_colors = 17;
    @customization_list = %w( t13 t23 t45 t47 t48 t52 t53 b2 b4 b10 b15 b19 a1 a3 a7 a8 )
    @ignorable_customizations = %w( )
    
    @starting_json = Hash.new { |hash,key| hash[key] = Hash.new {|hash2,key2| hash2[key2] = Hash.new } }
    @all_lengths = { "micro": "Micro-Mini", "knee": "Knee", "mini": "Mini", "midi": "Midi", "ankle": "Ankle", "maxi": "Maxi"}
    @search_directories = ["/home/ubuntu/Dropbox/renderfiles/Bridesmaid Collection/11. Models and Customisations/Classic Wrap/Rendered PNG's/Sides"]
    @starting_json['Micro-Mini']['default'] = { "front":
                                                  {
                                                    "bottom": "base_micro_mini_bottom_front",
                                                   "infront": "base_belt_infront_front",
                                                   "neckline": "base_neckline_front"
                                                  },
                                                "back":
                                                  {
                                                    "neckline": "base_neckline_back",
                                                   "infront": "base_belt_infront_back",
                                                   "bottom": "base_micro_mini_bottom_back"
                                                  }
                                              }
    
    @starting_json['Mini']['default'] = { "front":
                                            {
                                              "bottom": "base_mini_bottom_front",
                                             "infront": "base_belt_infront_front",
                                             "neckline": "base_neckline_front"
                                            },
                                          "back":
                                            {
                                              "neckline": "base_neckline_back",
                                             "infront": "base_belt_infront_back",
                                             "bottom": "base_mini_bottom_back"
                                            }
                                        }
    
    @starting_json['Knee']['default'] = { "front":
                                            {
                                              "bottom": "base_knee_bottom_front",
                                             "infront": "base_belt_infront_front",
                                             "neckline": "base_neckline_front"
                                            },
                                          "back":
                                            {
                                              "neckline": "base_neckline_back",
                                             "infront": "base_belt_infront_back",
                                             "bottom": "base_knee_bottom_back"
                                            }
                                        }

    

    @starting_json['Midi']['default'] = { "front":
                                            {
                                              "bottom": "base_midi_bottom_front",
                                             "infront": "base_belt_infront_front",
                                             "neckline": "base_neckline_front"
                                            },
                                          "back":
                                            {
                                              "neckline": "base_neckline_back",
                                             "infront": "base_belt_infront_back",
                                             "bottom": "base_midi_bottom_back"
                                            }
                                        }
    
    @starting_json['Ankle']['default'] = { "front":
                                             {
                                               "bottom": "base_ankle_bottom_front",
                                              "infront": "base_belt_infront_front",
                                              "neckline": "base_neckline_front"
                                             },
                                           "back":
                                             {
                                               "neckline": "base_neckline_back",
                                              "infront": "base_belt_infront_back",
                                              "bottom": "base_ankle_bottom_back"
                                             }
                                         }
    
    @starting_json['Maxi']['default'] = { "front":
                                            {
                                              "bottom": "base_maxi_bottom_front",
                                             "infront": "base_belt_infront_front",
                                             "neckline": "base_neckline_front"
                                            },
                                          "back":
                                            {
                                              "neckline": "base_neckline_back",
                                             "infront": "base_belt_infront_back",
                                             "bottom": "base_maxi_bottom_back"
                                            }
                                        }

  end
end
