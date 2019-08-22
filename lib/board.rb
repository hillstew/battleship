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
         # require 'pry'; binding.pry
         @x_range.each do |x|
              # binding.pry
              @cells[y + (x).to_s] = Cell.new(y + (x).to_s)
         end
    end

  end

  def valid_coordinate?(coordinate)
       @cells.has_key?(coordinate)
  end

  def valid_placement?(ship, coordinates)
    if ship.length == coordinates.length

         #test x/y axis consecutive
         x_range_index = @x_range.index(get_x_coordinate(coordinates[0]))
         x_test_consecutive = true
         coordinates.each_index do |c_index|
              if get_x_coordinate(coordinates[c_index]) != @x_range[x_range_index]
                   x_test_consecutive = false
                   x_range_index += 1
              end
         end

         y_range_index = @y_range.index(get_y_coordinate(coordinates[0]))
         y_test_consecutive = true
         coordinates.each_index do |c_index|
              if get_y_coordinate(coordinates[c_index]) != @y_range[y_range_index]
                   y_test_consecutive = false
                   y_range_index += 1
              end
         end




         # x/y coordinates same
         x_coordinate = get_x_coordinate(coordinates[0])
         y_coordinate = get_y_coordiante(coordinates[0])

         x_test_same = (coordinates.find_all {|coordinate| get_x_coordinate == x_coordinate}).length == ship.length
         y_test_same = (coordinates.find_all {|coordinate| get_y_coordinate == y_coordinate}).length == ship.length

         if x_test_consecutive && y_test_same
              true
         elsif x_test_same && y_test_consecutive
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


end
