class Turn
  attr_reader :player

  def initialize(player, computer)
    @shots = []
    @player = player
    @computer = computer
    @hit_message = nil
  end

  def player_take_shot
    coordinate_message
    coordinate = gets.chomp.upcase

    until @computer.board.valid_coordinate?(coordinate) do
      puts "Please enter a valid coordinate:"
      coordinate = gets.chomp.upcase
    end

    cell = @computer.board.cells.values_at(coordinate)
    if cell[0].coordinate == coordinate && cell[0].fired_upon? == false
      cell[0].fire_upon
      puts ""
      system('clear')
      if cell[0].render == "X"
        puts "Your shot of #{coordinate} results in a sunk ship!"
      elsif cell[0].render == "H"
        puts "Your shot at #{coordinate} made a hit."
      else
        puts "Your shot on #{coordinate} was a miss."
      end
    else
      system('clear')
      puts "Your shot of #{coordinate} has already been fired upon."
    end
  end

  def coordinate_message
    puts "Enter the coordinate for your shot:"
    print ">"
  end

  def show_boards
    puts "=============COMPUTER BOARD=============="
    print @computer.board.render(true)
    puts "=============PLAYER BOARD================"
    print @player.board.render(true)
  end

  def computer_take_shot
    shot = generate_random_shot
    cell = @player.board.cells.values_at(shot)

    while cell[0].hit_status do
      shot = generate_random_shot
      cell = @player.board.cells.values_at(shot)
    end

    if cell[0].coordinate == shot && cell[0].fired_upon? == false
      cell[0].fire_upon
      if cell[0].render == "X"
        puts "Computer shot of #{shot} results in a sunk ship!"

      elsif cell[0].render == "H"
        puts "Computer shot at #{shot} made a hit."
      else
        puts"Computer shot on #{shot} was a miss."
      end
    end
    puts ""
  end

  def generate_random_shot
    random_x = @player.board.x_range.sample.to_s
    random_y = @player.board.y_range.sample.to_s

    random_y + random_x
  end

end
