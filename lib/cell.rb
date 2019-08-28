
class Cell
  attr_reader   :coordinate, :hit_status
  attr_accessor :ship

  def initialize(coordinate)
    @coordinate = coordinate
    @ship = nil
    @hit_status = false
  end

  def empty?
    @ship == nil
  end

  def place_ship(ship)
    @ship = ship
  end

  def fire_upon
      @hit_status = true
      @ship.hit unless empty?
  end

  def fired_upon?
    @hit_status
  end

  def render(reveal_ship=false)
    if fired_upon?
      if (empty? == false)
        if @ship.sunk?
          "X"
        else
          "H"
        end
      else
        "M"
      end
    elsif reveal_ship == true && empty? == false
      "S"
    else
      "."
    end
  end
end
