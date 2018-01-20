class Dress

  attr_reader :customization_list
  attr_reader :starting_json
  attr_reader :all_lengths
  attr_reader :search_directories
  attr_reader :number_of_colors
  
  def initialize
    @name = 'Two Piece'
    @number_of_colors = 17;
    @customization_list = %w( t1 t8 t9 t37 t40 t41 t42 t43 t54 b3 b5 b14 b16 b19 a1 a4 a5 a6 ) 
    @starting_json = Hash.new { |hash,key| hash[key] = Hash.new {|hash2,key2| hash2[key2] = Hash.new } }
    @all_lengths = { "micro": "Micro-Mini", "knee": "Knee", "mini": "Mini", "midi": "Midi", "ankle": "Ankle", "maxi": "Maxi"}
    @search_directories = ["/home/ubuntu/Dropbox/renderfiles/Bridesmaid Collection/11. Models and Customisations/Two Piece/Render PNGs"]
    
    @starting_json['Micro-Mini']['default'] = { "front":
                                                  {
                                                    "bottom": "b4_micro_mini_bottom_front",
                                                   "belt": "default_belt_front",
                                                   "neckline": "default_two_piece_top_neckline_front"
                                                  },
                                                "back":
                                                  {
                                                    "bottom": "b4_micro_mini_bottom_back",
                                                   "belt":"default_belt_back",
                                                   "neckline": "default_two_piece_top_neckline_back"
                                                  }
                                              }
    
    @starting_json['Knee']['default'] = { "front":
                                                  {
                                                    "bottom": "b4_knee_bottom_front",
                                                   "belt": "default_belt_front",
                                                   "neckline": "default_two_piece_top_neckline_front"
                                                  },
                                                "back":
                                                  {
                                                    "bottom": "b4_knee_bottom_back",
                                                   "belt":"default_belt_back",
                                                   "neckline": "default_two_piece_top_neckline_back"
                                                  }
                                              }

    
    @starting_json['Mini']['default'] = { "front":
                                                  {
                                                    "bottom": "b4_mini_bottom_front",
                                                   "belt": "default_belt_front",
                                                   "neckline": "default_two_piece_top_neckline_front"
                                                  },
                                                "back":
                                                  {
                                                    "bottom": "b4_mini_bottom_back",
                                                   "belt":"default_belt_back",
                                                   "neckline": "default_two_piece_top_neckline_back"
                                                  }
                                              }

    @starting_json['Midi']['default'] = { "front":
                                                  {
                                                    "bottom": "b4_midi_bottom_front",
                                                   "belt": "default_belt_front",
                                                   "neckline": "default_two_piece_top_neckline_front"
                                                  },
                                                "back":
                                                  {
                                                    "bottom": "b4_midi_bottom_back",
                                                   "belt":"default_belt_back",
                                                   "neckline": "default_two_piece_top_neckline_back"
                                                  }
                                        }
    
    @starting_json['Ankle']['default'] = { "front":
                                                  {
                                                    "bottom": "b4_ankle_bottom_front",
                                                   "belt": "default_belt_front",
                                                   "neckline": "default_two_piece_top_neckline_front"
                                                  },
                                                "back":
                                                  {
                                                    "bottom": "b4_ankle_bottom_back",
                                                   "belt":"default_belt_back",
                                                   "neckline": "default_two_piece_top_neckline_back"
                                                  }
                                         }
    
    @starting_json['Maxi']['default'] = { "front":
                                                  {
                                                    "bottom": "b4_maxi_bottom_front",
                                                   "belt": "default_belt_front",
                                                   "neckline": "default_two_piece_top_neckline_front"
                                                  },
                                                "back":
                                                  {
                                                    "bottom": "b4_maxi_bottom_back",
                                                   "belt":"default_belt_back",
                                                   "neckline": "default_two_piece_top_neckline_back"
                                                  }
                                         }

  end
end
