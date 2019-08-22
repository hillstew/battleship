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
    assert_equal true, @board.valid_coordinate?("A1")
    assert_equal true, @board.valid_coordinate?("D4")
    assert_equal false, @board.valid_coordinate?("FF1")
    assert_equal false, @board.valid_coordinate?("A22")
  end

  def test_it_can_validate_placement_based_on_length
    assert_equal false, @board.valid_placement?(@cruiser, ["A1", "A2"])
    assert_equal false, @board.valid_placement?(@submarine, ["A2", "A3", "A4"])
    assert_equal true, @board.valid_placement?(@submarine, ["A1", "A2"])
  end

  def test_it_can_validate_placement_if_coordinates_are_consecutive
    assert_equal false, @board.valid_placement?(@cruiser, ["A1", "A2", "A4"])
    assert_equal false, @board.valid_placement?(@submarine, ["A1", "C1"])
    assert_equal false, @board.valid_placement?(@cruiser, ["A3", "A2", "A1"])
    assert_equal false, @board.valid_placement?(@submarine, ["C1", "B1"])
    assert_equal true, @board.valid_placement?(@cruiser, ["B1", "C1", "D1"])
  end

  def test_it_can_validate_placement_if_coordinates_are_diagonal
    assert_equal false, @board.valid_placement?(@cruiser, ["A1", "B2", "C3"])
    assert_equal false, @board.valid_placement?(@submarine, ["C2", "D3"])
  end

  def test_it_can_place_a_ship
    @board.place(@cruiser, ["A1", "A2", "A3"])
    cell_1 = board.cells["A1"]
    cell_2 = board.cells["A2"]
    cell_3 = board.cells["A3"]
    assert_equal @cruiser, cell_1.ship
    assert_equal @cruiser, cell_2.ship
    assert_equal @cruiser, cell_3.ship
    assert_equal true, cell_3.ship == cell_2.ship
  end

  def test_it_will_not_overlap_when_ship_placed
    @board.place(@cruiser, ["A1", "A2", "A3"])
    expected = @board.valid_placement?(@submarine, ["A1", "B1"])
    assert_equal false, expected
  end

  def test_it_can_render_a_board
    @board.place(cruiser, ["A1", "A2", "A3"])
    expected = @board.render
    actual = "  1 2 3 4 \nA . . . . \nB . . . . \nC . . . . \nD . . . . \n"
    assert_equal expected, actual
  end

  def test_it_can_render_with_argument
    @board.place(cruiser, ["A1", "A2", "A3"])
    expected = @board.render(true)
    actual = "  1 2 3 4 \nA S S S . \nB . . . . \nC . . . . \nD . . . . \n"
    assert_equal expected, actual
  end
end
