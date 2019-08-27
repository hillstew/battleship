require './lib/cell'

class Board
  attr_reader :cells, :x_range, :y_range

  def initialize(x_range, y_range)

    @cells = Hash.new
    @x_range = (1..x_range).to_a
    @y_range = ("A"..y_range).to_a

    #build hash of values
    @y_range.each do |y|
      @x_range.each do |x|
        @cells[y + (x).to_s] = Cell.new(y + (x).to_s)
      end
    end

  end

  def valid_coordinate?(coordinate)
    @cells.has_key?(coordinate)
  end

  def valid_placement?(ship, coordinates)
    if (ship.length == coordinates.length) && !overlapping?(coordinates)

      if x_test_consecutive(coordinates) && y_test_same(ship, coordinates)
        true
      elsif x_test_same(ship, coordinates) && y_test_consecutive(coordinates)
        true
      else
        false
      end
    else
      false
    end
  end

  def get_x_coordinate(coordinate)
    coordinate.delete('A-Z')
  end

  def get_y_coordinate(coordinate)
    coordinate.delete('0-9')
  end

  #test x/y axis consecutive
  def x_test_consecutive(coordinates)
    x_range_index = @x_range.index(get_x_coordinate(coordinates[0]).to_i)
    x_test_consecutive = true
    coordinates.each_index do |c_index|
      if get_x_coordinate(coordinates[c_index]).to_i != @x_range[x_range_index]
        x_test_consecutive = false
      end
        x_range_index += 1
    end

    x_test_consecutive
  end

  def y_test_consecutive(coordinates)
    y_range_index = @y_range.index(get_y_coordinate(coordinates[0]))

    y_test_consecutive = true
    coordinates.each_index do |c_index|
      if get_y_coordinate(coordinates[c_index]) != @y_range[y_range_index]
        y_test_consecutive = false
      end
        y_range_index += 1
     end

    y_test_consecutive
  end

  def x_test_same(ship, coordinates)
    x_test_same = coordinates.find_all do |coordinate|
      get_x_coordinate(coordinate) == get_x_coordinate(coordinates[0])
    end

    x_test_same.length == ship.length
  end

  def y_test_same(ship, coordinates)
    y_test_same = coordinates.find_all do |coordinate|
      get_y_coordinate(coordinate) == get_y_coordinate(coordinates[0])
    end

    y_test_same.length == ship.length
  end

  def place(ship, coordinates)

    if valid_placement?(ship, coordinates)
      coordinates.each do |coordinate|
        @cells[coordinate].ship = ship
      end
    else
      # code for signaling output for no placement because not valid or overlapping
    end
  end

  #returns true if cells requested to place ship already have ship
  def overlapping?(coordinates)
    cell_used = false
    coordinates.each do |coordinate|
    if !cell_used
      cell_used = !@cells[coordinate].empty?
    end
  end
    cell_used
  end

  def render(reveal_status = false)
    y_axis_spaces = @y_range[-1].length #determine # of spaces for the y-axis max

    output =  "".rjust(y_axis_spaces) + " " + @x_range*" "+ " \n"

    @y_range.each do |y|
      output += y + " ".rjust(y_axis_spaces) + " "
      @x_range.each do |x_range_coordinate|
        output += @cells[y + x_range_coordinate.to_s].render(reveal_status) + " "
      end
        output += "\n"
    end

    output
  end

end
