require 'pry'

class Board
  attr_reader :cells, :x_range, :y_range

  # def initialize()
  #   @cells = {
  #        "A1" => Cell.new("A1"),
  #        "A2" => Cell.new("A2"),
  #        "A3" => Cell.new("A3"),
  #        "A4" => Cell.new("A4"),
  #        "B1" => Cell.new("B1"),
  #        "B2" => Cell.new("B2"),
  #        "B3" => Cell.new("B3"),
  #        "B4" => Cell.new("B4"),
  #        "C1" => Cell.new("C1"),
  #        "C2" => Cell.new("C2"),
  #        "C3" => Cell.new("C3"),
  #        "C4" => Cell.new("C4"),
  #        "D1" => Cell.new("C5"),
  #        "D2" => Cell.new("C6"),
  #        "D3" => Cell.new("C7"),
  #        "D4" => Cell.new("C8"),
  #   }
  #
  # end

  #for later implementation of variable board
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
    # require 'pry'; binding.pry
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
       binding.pry

       if valid_placement?(ship, coordinates)
            coordinates.each do |coordinate|
                 binding.pry
                 @cells[coordinate].ship = ship
            end
       else
            # code for signaling output for no placement because not valid or overlapping
       end
  end

  #returns true if cells requested to place ship already have ship
  def overlapping?(coordinates)
       # binding.pry
       cell_used = false
       coordinates.each do |coordinate|
         if !cell_used
              cell_used = !@cells[coordinate].empty?
         end
       end
       cell_used
  end

end
