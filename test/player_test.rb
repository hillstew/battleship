require 'minitest/autorun'
require 'minitest/pride'
require './lib/player'
require './lib/board'

class PlayerTest < Minitest::Test
  def setup
    @player = Player.new
    @computer = Player.new(computer=true)
  end

  def test_it_exists
    assert_instance_of Player, @player
  end

  def test_it_has_attributes
    assert_equal [], @player.shots
    assert_instance_of Board, @player.board
  end
end
