require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship'
require './lib/cell'
require './lib/board'

class BoardTest < Minitest::Test

  def setup
    # @board = Board.new
    @board = Board.new(10, "F") #infinite board
    @cruiser = Ship.new("Cruiser", 3)
    @submarine = Ship.new("Submarine", 2)
  end

  def test_it_exists
    assert_instance_of Board, @board
  end

  def test_it_has_cells
    assert_instance_of Hash, @board.cells
    assert_equal 60, @board.cells.count

    @board.cells.values.each do |value|
    assert_instance_of Cell, value
    end
  end

  def test_it_can_validate_a_coordinate
    assert @board.valid_coordinate?("A1")
    assert @board.valid_coordinate?("D4")

  end

  def test_it_can_validate_coordinate_false
    refute_equal false, @board.valid_coordinate?("FF1")
    refute_equal false, @board.valid_coordinate?("A22")
  end

  def test_it_can_validate_placement_based_on_length
    assert @board.valid_placement?(@submarine, ["A1", "A2"])
  end

  def test_it_can_validate_placement_based_on_length_false
    refute_equal false, @board.valid_placement?(@cruiser, ["A1", "A2"])
    refute_equal false, @board.valid_placement?(@submarine, ["A2", "A3", "A4"])
  end

  def test_it_can_validate_placement_if_coordinates_are_consecutive
    assert @board.valid_placement?(@cruiser, ["B1", "C1", "D1"])
    assert @board.valid_placement?(@cruiser, ["F3", "F4", "F5"])
  end

  def test_it_can_validate_placement_if_coordinates_arenot_consecutive
   refute_equal false, @board.valid_placement?(@cruiser, ["A1", "A2", "A4"])
   refute_equal false, @board.valid_placement?(@submarine, ["A1", "C1"])
   refute_equal false, @board.valid_placement?(@cruiser, ["A3", "A2", "A1"])
   refute_equal false, @board.valid_placement?(@submarine, ["C1", "B1"])
  end

  def test_it_can_validate_placement_if_coordinates_are_diagonal
    refute_equal false, @board.valid_placement?(@cruiser, ["A1", "B2", "C3"])
    refute_equal false, @board.valid_placement?(@submarine, ["C2", "D3"])
  end

  def test_it_can_place_a_ship
    @board.place(@cruiser, ["A1", "A2", "A3"])
    # cell_1 = board.cells["A1"]
    # cell_2 = board.cells["A2"]
    # cell_3 = board.cells["A3"]
    assert_equal @cruiser, @board.cells["A1"].ship
    assert_equal @cruiser, @board.cells["A2"].ship
    assert_equal @cruiser, @board.cells["A3"].ship
    assert @board.cells["A1"].ship == @board.cells["A2"].ship
  end

  def test_it_will_not_overlap_when_ship_placed
    @board.place(@cruiser, ["A1", "A2", "A3"])
    refute_equal false, @board.valid_placement?(@submarine, ["A1", "B1"])
  end

  def test_it_can_render_a_board
    @board2 = Board.new(4, "D") #infinite board
    @board2.place(@cruiser, ["A1", "A2", "A3"])
    expected = "  1 2 3 4 \nA  . . . . \nB  . . . . \nC  . . . . \nD  . . . . \n"
    assert_equal expected, @board2.render
  end

  def test_it_can_render_with_argument
    @board2 = Board.new(4, "D") #infinite board
    @board2.place(@cruiser, ["A1", "A2", "A3"])
    expected = "  1 2 3 4 \nA  S S S . \nB  . . . . \nC  . . . . \nD  . . . . \n"
    assert_equal expected, @board2.render(true)
  end
end
