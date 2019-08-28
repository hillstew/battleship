require './lib/board'

class Player
  attr_reader :shots, :board, :ships, :computer

  def initialize(computer=false)
    @computer = computer
    @board = Board.new(10, "F")
    @ships = []
  end

  def all_sunk?
    @ships.all? do |ship|
      ship.sunk?
    end
  end
end
