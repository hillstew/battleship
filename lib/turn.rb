# User board is displayed showing hits, misses, sunken ships, and ships
# Computer board is displayed showing hits, misses, and sunken ships
# Computer chooses a random shot
# Computer does not fire on the same spot twice
# User can choose a valid coordinate to fire on
# Entering invalid coordinate prompts user to enter valid coordinate
# Both computer and player shots are reported as a hit, sink, or miss
# User is informed when they have already fired on a coordinate
# Board is updated after a turn

class Turn
  attr_reader :player

  def initialize(player, computer)
    @shots = []
    @player = player
    @computer = computer
  end
  # gathering info to fire coordinate
  # execute shot
  # report result

  def get_coordinate_to_fire_on
    coordinate_message
    coordinate = gets.chomp.split

    while @computer.board.valid_coordinate?(coordinate) == false
      puts "Please enter a valid coordinate:"
      coordinate_message
      coordinate = gets.chomp.split
    end

    @computer.board.find do |cell|
      if cell == coordinate && !cell.fired_upon?
        cell.fire_upon
      else
        # message already been fired_upon
      end

    end
    computer_take_shot
  end

  def show_boards
    puts "=============COMPUTER BOARD=============="
    print @computer.board.render
    puts "=============PLAYER BOARD=============="
    print @player.board.render(true)
  end

  def computer_take_shot
    shot = generate_random_shot

    @player.board.find do |cell|
      if cell == shot && !cell.fired_upon?
        cell.fire_upon
      else
        # message already been fired_upon
      end
    end
  end

  def generate_random_shot

  end

  def coordinate_message
    puts "Enter the coordinate for your shot:"
    print ">"
  end


end
