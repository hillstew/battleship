require 'minitest/autorun'
require 'minitest/pride'
require './lib/game'

class GameTest < Minitest::Test
  def setup
    @game = Game.new
    @computer = Player.new(computer=true)
  end

  def test_it_exists
    assert_instance_of Game, @game
  end
end
