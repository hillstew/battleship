require './lib/board'
require 'pry'

class Player
  attr_reader :shots, :board

  def initialize(computer=false)
    @computer = computer
    @shots = []
    @board = Board.new(10, "F")
  end
end
