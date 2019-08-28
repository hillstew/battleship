require 'minitest/autorun'
require 'minitest/pride'
require './lib/turn'
require './lib/player'
require './lib/board'

class TurnTest < Minitest::Test
  def setup
    @player = Player.new
    @computer = Player.new(true)
    @turn = Turn.new(@player,@computer)
  end

  def test_it_exists
    assert_instance_of Turn, @turn
  end

  def test_it_has_attributes
    assert_equal @player, @turn.player
    assert_instance_of Player, @turn.player
  end

  def test_method_generate_random_shot
    assert @player.board.cells.has_key?(@turn.generate_random_shot) #test random shot is with the board range
  end
end
