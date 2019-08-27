# test implementation in case we need it

class Person

  def initialize(name)
    @all_sunk   = false
    @name       = name

    continue_play #starts the interaction pattern
  end

  def game_over?
    @all_sunk
  end

  def continue_play

    puts "Welcome to BATTLESHIP"
    puts "Enter p to play. Enter q to quit."

          user_continue_play = gets.chomp.to_s.downcase
          if user_continue_play == 'p'
            prompt_board_size


            auto_place_ships  # computer places ships
            #prompts person to place ships
          else
              puts "Thank you. Good-bye."
          end

  end

  def prompt_board_size
    puts "How many columns do you want to play?"
    user columns = gets.chomp


    puts "How many rows do you want to play?"
  end

  def auto_place_ships

  end

end
