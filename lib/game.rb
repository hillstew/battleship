require './lib/player'
require './lib/ship'
require './lib/board'
require './lib/turn'
require "pry"

class Game
  attr_reader :player, :computer

  def initialize
    @player = Player.new
    @computer = Player.new(true)
  end

  def start
    puts "Welcome to BATTLESHIP"
    puts "Enter p to play. Enter q to quit."
    response = gets.chomp
    if response == "p"
      setup_computer_ships
      place_ship_message

      while check_ships
        @current_turn = Turn.new(@player, @computer)
        @current_turn.show_boards
        @current_turn.get_coordinate_to_fire_on
        game_over?
      end



    end
  end

  def place_ship_message
    puts "I have laid out my ships on the grid."
    puts "You now need to lay out your two ships."
    puts "The Cruiser is two units long and the Submarine is three units long."
    print @player.board.render
    place_player_ship("Cruiser", 3)
    place_player_ship("Submarine", 2)
  end

  def place_player_ship(type, length)
    ship = Ship.new(type, length)
    @player.ships << ship
    coordinate_message(type, length)
    coordinates = gets.chomp.split

    while @player.board.valid_placement?(ship, coordinates) == false
      puts "Those are invalid coordinates. Please try again:"
      coordinate_message(type, length)
      coordinates = gets.chomp.split
    end

    @player.board.place(ship, coordinates)
    print @player.board.render(true)
  end

  def place_computer_ship(ship, coordinates)
    #valid_placement? already passed with the random coordinates
    @computer.board.place(ship, coordinates)
    print @computer.board.render(true)
  end

  def check_ships
     @players.any? do |player|
       player.all_sunk?
     end
  end

  def coordinate_message(type, length)
    puts "Enter the squares for the #{type} (#{length} spaces):"
    print ">"
  end

  def setup_computer_ships
    #hardcoded ships
    # binding.pry
    @computer.ships << Ship.new("Cruiser", 3)
    @computer.ships << Ship.new("Submarine", 2)

    @computer.ships.each do |ship|
      binding.pry
      random_coordinates = generate_random_coordinates(ship.length)

      unless @computer.board.valid_placement?(ship, random_coordinates)
        random_coordinates = generate_random_coordinates(ship.length)
      end
      binding.pry
      place_computer_ship(ship, random_coordinates)
      end
  end

  def generate_random_coordinates(length)

    random_x = @computer.board.x_range.sample.to_s
    random_y = @computer.board.y_range.sample.to_s
    random_direction = ["H", "V"].sample
    coordinates = [random_y + random_x]
    x_range_index = @computer.board.x_range.index(random_x.to_i)
    y_range_index = @computer.board.y_range.index(random_y.to_s)

    (length-1).times do
      if random_direction == "H"
        binding.pry
        next_x = @computer.board.x_range[x_range_index + 1]
        x_range_index += 1
        coordinates << random_y + next_x.to_s
      else
        binding.pry
        next_y = @computer.board.y_range[y_range_index + 1]
        y_range_index += 1
        coordinates << next_y + random_x
      end
    end

    coordinates
  end

end

game = Game.new
game.start