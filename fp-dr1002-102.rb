class Dress

  attr_reader :customization_list
  attr_reader :starting_json
  attr_reader :all_lengths
  attr_reader :search_directories
  attr_reader :number_of_colors
  
  def initialize
    @name = 'Fit & Flare'
    @number_of_colors = 17;
    @customization_list = %w( t1 t3 t5 t6 t9 t15 t24 t27 t31 t36 t46 t51 t57 t60 t63 b3 b4 b5 b14 a2 a5 ) 
    @starting_json = Hash.new { |hash,key| hash[key] = Hash.new {|hash2,key2| hash2[key2] = Hash.new } }
    @all_lengths = { "micro": "Micro-Mini", "knee": "Knee", "mini": "Mini", "midi": "Midi", "ankle": "Ankle", "maxi": "Maxi"}
    @search_directories = ["/home/ubuntu/Dropbox/renderfiles/Bridesmaid Collection/11. Models and Customisations/Fit and Flare/Rendered PNG's", "/home/ubuntu/Dropbox/renderfiles/Bridesmaid Collection/11. Models and Customisations/The Column Dress and Jump Suit", "/home/ubuntu/Dropbox/renderfiles/Bridesmaid Collection/11. Models and Customisations/Two Piece/Render PNGs"]
    
    @starting_json['Micro-Mini']['default'] = { "front":
                                                  {
                                                    "bottom": "base_micro_mini_bottom_front",
                                                   "neckline": "base_top_neckline_front"
                                                  },
                                                "back":
                                                  {
                                                    "bottom": "base_micro_mini_bottom_back",
                                                   "neckline": "base_top_neckline_back"
                                                  }
                                              }
    
    @starting_json['Knee']['default'] = { "front":
                                                  {
                                                    "bottom": "base_knee_bottom_front",
                                                   "neckline": "base_top_neckline_front"
                                                  },
                                                "back":
                                                  {
                                                    "bottom": "base_knee_bottom_back",
                                                   "neckline": "base_top_neckline_back"
                                                  }
                                              }

    
    @starting_json['Mini']['default'] = { "front":
                                                  {
                                                    "bottom": "base_mini_bottom_front",
                                                   "neckline": "base_top_neckline_front"
                                                  },
                                                "back":
                                                  {
                                                    "bottom": "base_mini_bottom_back",
                                                   "neckline": "base_top_neckline_back"
                                                  }
                                              }

    @starting_json['Midi']['default'] = { "front":
                                                  {
                                                    "bottom": "base_midi_bottom_front",
                                                   "neckline": "base_top_neckline_front"
                                                  },
                                                "back":
                                                  {
                                                    "bottom": "base_midi_bottom_back",
                                                   "neckline": "base_top_neckline_back"
                                                  }
                                        }
    
    @starting_json['Ankle']['default'] = { "front":
                                                  {
                                                    "bottom": "base_ankle_bottom_front",
                                                   "neckline": "base_top_neckline_front"
                                                  },
                                                "back":
                                                  {
                                                    "bottom": "base_ankle_bottom_back",
                                                   "neckline": "base_top_neckline_back"
                                                  }
                                         }
    
    @starting_json['Maxi']['default'] = { "front":
                                                  {
                                                    "bottom": "base_maxi_bottom_front",
                                                   "neckline": "base_top_neckline_front"
                                                  },
                                                "back":
                                                  {
                                                    "bottom": "base_maxi_bottom_back",
                                                   "neckline": "base_top_neckline_back"
                                                  }
                                         }

  end

  
  
end
