require './lib/player'
require './lib/ship'
require './lib/board'

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
    place_cruiser
  end

  def place_cruiser
    cruiser = Ship.new("Cruiser", 3)
    puts "Enter the squares for the Cruiser (3 spaces):"
    print ">"
    coordinates = gets.chomp.split
    if @player.board.valid_placement?(cruiser, coordinates)
      @player.board.place(cruiser, coordinates)
      print @player.board.render(true)
    end
    place_submarine
  end

  def place_submarine
    submarine = Ship.new("Submarine", 2)
    puts "Enter the squares for the Submarine (2 spaces):"
    print ">"
    coordinates = gets.chomp.split
    if @player.board.valid_placement?(submarine, coordinates)
      @player.board.place(submarine, coordinates)
      print @player.board.render(true)
    end
  end
end

game = Game.new
game.start
