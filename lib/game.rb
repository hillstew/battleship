require './lib/player'
require './lib/ship'
require './lib/board'
require "pry"

class Game
  attr_reader :player, :computer

  def initialize
    @player = Player.new
    @computer = Player.new(true)
  end

  def start
    welcome_prompt
  end

  def welcome_prompt
    puts "Welcome to BATTLESHIP"
    puts "Enter p to play. Enter q to quit."
    response = gets.chomp
    if response == "p"
      # place_computer_ships
      place_ship_message
    end
  end


  def place_computer_ships

  end

  def place_ship_message
    puts "I have laid out my ships on the grid."
    puts "You now need to lay out your two ships."
    puts "The Cruiser is two units long and the Submarine is three units long."
    print @player.board.render
    place_ship("Cruiser", 3)
    place_ship("Submarine", 2)
  end

  def place_ship(type, length)
    ship = Ship.new(type, length)
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

  def coordinate_message(type, length)
    puts "Enter the squares for the #{type} (#{length} spaces):"
    print ">"
  end

end

game = Game.new
game.start
