require 'pry'

class Turn
  attr_reader :player

  def initialize(player, computer)
    @shots = []
    @player = player
    @computer = computer
    @hit_message = nil
  end

  def get_coordinate_to_fire_on
    coordinate_message
    coordinate = gets.chomp

    until @computer.board.valid_coordinate?(coordinate) do
      puts "Please enter a valid coordinate:"
      coordinate = gets.chomp
    end

    cell = @computer.board.cells.values_at(coordinate)
    if cell[0].coordinate == coordinate && cell[0].fired_upon? == false
      cell[0].fire_upon
      if cell[0].render == "X"
        @hit_message = "Your shot of #{coordinate} results in a sunk ship!"
      elsif cell[0].render == "H"
        @hit_message = "Your shot at #{coordinate} made a hit."
      else
        @hit_message = "Your shot on #{coordinate} was a miss."
      end
    else
      @hit_message = "Your shot of #{coordinate} has already been fired upon."
    end
    puts ""
    puts @hit_message
    puts ""
    computer_take_shot
  end

  def coordinate_message
    puts "Enter the coordinate for your shot:"
    print ">"
  end

  def show_boards
    puts "=============COMPUTER BOARD=============="
    print @computer.board.render
    puts "=============PLAYER BOARD================"
    print @player.board.render(true)
  end

  def computer_take_shot
    shot = generate_random_shot
    cell = @player.board.cells.values_at(shot)
    binding.pry
    unless cell[0].hit_status
      shot = generate_random_shot
    end

    if cell[0].coordinate == shot && cell[0].fired_upon? == false
      cell[0].fire_upon
      if cell[0].render == "X"
        @hit_message = "Computer shot of #{shot} results in a sunk ship!"
      elsif cell[0].render == "H"
        @hit_message = "Computer shot at #{shot} made a hit."
      else
        @hit_message = "Computer shot on #{shot} was a miss."
      end
    end
    puts ""
    puts @hit_message
    puts ""
  end

  def generate_random_shot
    random_x = @player.board.x_range.sample.to_s
    random_y = @player.board.y_range.sample.to_s

    random_y + random_x
  end




end
