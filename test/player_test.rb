require 'minitest/autorun'
require 'minitest/pride'
require './lib/player'
require './lib/board'

class PlayerTest < Minitest::Test
  def setup
    @player = Player.new
    @player2 = Player.new(true)
  end

  def test_it_exists
    assert_instance_of Player, @player
  end

  def test_it_has_attributes
    assert_instance_of Board, @player.board
    assert_equal [], @player.ships
    assert_equal true, @player2.computer
  end
end
