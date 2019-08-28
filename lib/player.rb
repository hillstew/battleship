require './lib/board'
require 'pry'

class Player
  attr_reader :shots, :board, :ships

  def initialize(computer=false)
    @computer = computer
    @turns = []
    @board = Board.new(10, "F")
    @ships = []
    @current_turn = false
  end

  def all_sunk?
    @ships.all? do |ship|
      ship.sunk?
    end
  end
end
